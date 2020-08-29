(after! circe
  (set-irc-server! "chat.freenode.net"
    `(:tls t
      :port 6697
      :nick "ITL"
      :sasl-username ,(+pass-get-user "my/dev/freenode")
      :sasl-password (lambda (&rest _) (+pass-get-secret "my/dev/freenode"))
      :channels ("#mkdocs"))))
