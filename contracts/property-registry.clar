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
