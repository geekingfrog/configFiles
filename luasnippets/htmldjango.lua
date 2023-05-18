return {
  s({trig="match", dscr="match for askama"},
    {t("{% match "), i(1), t({" %}", ""}), i(2), t({"", "{% endmatch %}"})}
  ),

  s({trig="when", dscr="pattern match when for askama"},
    {t("{% when "), i(1), t({" %}", ""})}
  ),
}
