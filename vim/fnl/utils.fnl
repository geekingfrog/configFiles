(local fennel (_G.tangerine.fennel :latest))
(λ string? [x]
  (-> x
      type
      (= :string)))

{:view fennel.view : string?}
