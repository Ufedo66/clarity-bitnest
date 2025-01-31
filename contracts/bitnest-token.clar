;; BitNest Token Implementation
(define-fungible-token bnt-token)

(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-insufficient-balance (err u101))

(define-data-var token-name (string-ascii 32) "BitNest Token")
(define-data-var token-symbol (string-ascii 10) "BNT")

(define-public (transfer (amount uint) (sender principal) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender sender) (err u1))
    (ft-transfer? bnt-token amount sender recipient)
  )
)

(define-public (mint (amount uint) (recipient principal))
  (begin
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    (ft-mint? bnt-token amount recipient)
  )
)
