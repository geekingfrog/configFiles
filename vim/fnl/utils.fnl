(local fennel (_G.tangerine.fennel :latest))
(lambda string? [x]
  (-> x
      type
      (= :string)))

{:view fennel.view : string?}

