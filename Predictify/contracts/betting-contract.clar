(define-map events
  { event-id: uint }
  {
    description: (string-ascii 100),
    resolved: bool,
    winning-option: (optional uint)
  })

(define-map bets
  { event-id: uint, better: principal }
  {
    option: uint,
    amount: uint
  })

;; Create a new event
(define-public (create-event (event-id uint) (description (string-ascii 100)))
  (ok (map-set events
    { event-id: event-id }
    {
      description: description,
      resolved: false,
      winning-option: none
    }
  ))
)

;; Place a bet on an existing event
(define-public (place-bet (event-id uint) (option uint) (amount uint))
  (begin
    ;; Ensure the event exists
    (asserts! (is-some (map-get? events { event-id: event-id })) (err u100))

    ;; Place the bet
    (map-set bets
      { event-id: event-id, better: tx-sender }
      {
        option: option,
        amount: amount
      }
    )
    (ok true)
  )
)

;; Retrieve bet details for a user on a specific event (read-only function)
(define-read-only (get-bet (event-id uint) (better principal))
  (map-get? bets { event-id: event-id, better: better })
)
