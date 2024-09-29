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

