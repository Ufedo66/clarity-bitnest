;; Property Registry Contract
(define-map properties
  { property-id: uint }
  {
    owner: principal,
    location: (string-ascii 256),
    available: bool,
    price: uint
  }
)

(define-data-var property-counter uint u0)

;; Error constants
(define-constant err-property-not-found (err u100))
(define-constant err-not-owner (err u101))

(define-public (register-property 
  (location (string-ascii 256))
  (price uint)
)
  (let
    (
      (new-id (+ (var-get property-counter) u1))
    )
    (begin
      (map-insert properties
        { property-id: new-id }
        {
          owner: tx-sender,
          location: location,
          available: true,
          price: price
        }
      )
      (var-set property-counter new-id)
      (ok new-id)
    )
  )
)

(define-public (update-property-status
  (property-id uint)
  (available bool)
)
  (let (
    (property (unwrap! (map-get? properties {property-id: property-id}) err-property-not-found))
  )
    (begin
      (asserts! (is-eq tx-sender (get owner property)) err-not-owner)
      (ok (map-set properties
        {property-id: property-id}
        (merge property {available: available})
      ))
    )
  )
)
