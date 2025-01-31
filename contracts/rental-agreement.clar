;; Rental Agreement Contract
(define-map agreements
  { agreement-id: uint }
  {
    landlord: principal,
    tenant: principal,
    property-id: uint,
    rent-amount: uint,
    start-date: uint,
    end-date: uint,
    status: (string-ascii 20)
  }
)

(define-data-var agreement-counter uint u0)

(define-public (create-agreement 
  (property-id uint)
  (tenant principal)
  (rent-amount uint)
  (start-date uint)
  (end-date uint)
)
  (let
    (
      (new-id (+ (var-get agreement-counter) u1))
    )
    (begin
      (map-insert agreements
        { agreement-id: new-id }
        {
          landlord: tx-sender,
          tenant: tenant,
          property-id: property-id,
          rent-amount: rent-amount,
          start-date: start-date,
          end-date: end-date,
          status: "active"
        }
      )
      (var-set agreement-counter new-id)
      (ok new-id)
    )
  )
)
