From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Fri,  5 Jun 2015 17:09:57 -0700
Subject: [Cocci] [PATCH 0/4] backports: SmPL patch equivalence support
Message-ID: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

A long time ago I wrote SmPL <--> patch equivalence proof support
for backports but put that work on hold as I found it could be
useful as a generic tool. Quite a bit of time has passed and I
haven't gotten to that again so just merge this for now. If we want
to generalize it we can do so later.

This goes with an example patch being transformed.

Luis R. Rodriguez (4):
  patches: remove bt_sock_stream_recvmsg() and bt_sock_recvmsg() from
    ifdefs
  patches: change 0054-struct-proto_ops-sig backport strategy
  gentree.py: add SmPL patch equivalence proof support
  patches: provide 0054-struct-proto_ops-sig SmPL patch replacement

 gentree.py                                         |  71 ++++++-
 .../network/0054-struct-proto_ops-sig.cocci        | 177 +++++++++++++++++
 .../0054-struct-proto_ops-sig/bluetooth.patch      | 212 ---------------------
 .../0054-struct-proto_ops-sig/ieee802154.patch     |  79 --------
 .../network/0054-struct-proto_ops-sig/nfc.patch    |  59 ------
 5 files changed, 240 insertions(+), 358 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig.cocci
 delete mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
 delete mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
 delete mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch

-- 
2.3.2.209.gd67f9d5.dirty
