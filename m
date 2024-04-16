Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3BEC05023
	for <cocci@archiver.kernel.org>; Tue, 16 Apr 2024 12:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=qhsT3OsX+8+Dm7V8mu8l100PwluW1lC8VCNPSaNVky0=;
  b=cb1HsQll3m5ZShAjzdoqdMjJvYOWnxCjD6wT8yRNZTFDNMcgi4cktqnq
   9XeRIEZ755w04Pahmm1AsSh/7OnZOw4McHEWYwn4N0PZivUa2r4R7YIyy
   gUtZ3b5qXRrOp0lGkciq7IGejxHubptBDqUtYDqZ5JGCzfVBDkV1PLjf9
   o=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@csgroup.eu
X-IronPort-AV: E=Sophos;i="6.07,206,1708383600"; 
   d="scan'208";a="161851098"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2024 14:14:36 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1A2AFE0133; Tue, 16 Apr 2024 14:14:36 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id ABB95E0035
	for <cocci@sympa.inria.fr>; Tue, 16 Apr 2024 13:32:54 +0200 (CEST)
IronPort-SDR: 661e61e5_ra/28mxx/wS5Sx7QCX0q6dN15+6Pj3aFg+lqi2U3huOrra3
 +viUBKpOP0gxBm/qpOhAa4w563M5Yi1nkJMHtpw==
X-IPAS-Result: =?us-ascii?q?A0EkAACJYR5mhgKnZTRaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYFxUnoCVzIHCEiEVoNMA4UtiGyEPpd3gVYUgWoPAQMBCwI7CQQBA?=
 =?us-ascii?q?QMBA4R/AhaIBSAGAQQxCA4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECEAEBAQEgGQcOECeFbQ2CZwFqNHQBAQEBAQEBAQECAQEBIgIBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEdAggFfAIBAxIREQwBASoKAwEPAgEIDgwCERUCAgIvFRACBAENBQIBA?=
 =?us-ascii?q?R6CXgGCKwMxBAIOpxMBgUACAosggTKBAYIKAQEGBATbHCJXgWEDBoEaLgGIL?=
 =?us-ascii?q?QGBWYQjCYQ3NoFVRIEVJwuCeD6DfEcXIQIFgxyCaIchiG5bggGDT4EhL4Nxh?=
 =?us-ascii?q?iMJS30cA1kgEgFVEyILBAwaAhsUDSQjAik+AwkKEAIWAx0UBDARCQsmAyoGN?=
 =?us-ascii?q?gISDAYGBlsgFgkEIwMIBANQAyBwEQMEGgQLB3WBfIE9BBNEAgENA4EyBooPD?=
 =?us-ascii?q?IF9gQwCBSEEJYFOKYEpgwlLcRWBCAKCfYFgA0QdQAIBC209NQYDCxsGIx2eC?=
 =?us-ascii?q?QGDfCcYRoEfk0MdQoMyjz+fBTQHhBaBWwYMiiGVJAYTL4QFpi+YYiCCNIkpg?=
 =?us-ascii?q?XeVBU+FEwIEAgQFAg8BAQaBZQE4gVxNJoMAAQEyTwMZD44gGYRihBOKKAGGX?=
 =?us-ascii?q?0Q0AjkCBwEKAQEDCYkigUgBAQ?=
IronPort-PHdr: A9a23:asGrQhalxvBugE9u761Q/Kr/LTG034qcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1g6PBNqGoKsZw8Pt8IneGkU4oqy9+EgYd5JNUxJXwe43pCcHRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCS5bL9oM
 Rm7rwXcusYLjYZiN6081gbHrnxUdutZwm9lOUidkxHg6Mmu4ZVt6T5Qu/Uv985BVaX1YaE1R
 qFGATolLm44+tTluQHMQgWT6HQcVH4WkgdTDAje8B76RJbxvTDkued7xSKXINf5TbEwWTSl8
 qdrVBrlgzoJOjIl7G3ajNF7gblFqxy9uRNw34/UYJmUNPVgeKPdYcgaTndFUspISiBNHp+wY
 44JAuEcP+hXspP9qkMOoxWgGwSiGf/vxDFLiH/436I13fguHw7J0wE7A9IBq27ZoMnpOKsMU
 +24yrTDwzXZb/NR3Dfw8JbFchA7ofGNRrJwbc3RyVEvFwzbk16er5LqPymS1uUNrmOW6PZvV
 eK1i24msAFxvj+vxt8siobXnI4Vzk7L9T9+wIc1PtC3VFV7YdG+EJtXqiGaL5F6Td0/Q2xxv
 isx17IJt4KhcicQ1JQn2wDQa+aBc4WQ7R/uVeWcLzh3iX9qeLyymRi8/Eyvx+PyS8S5zkhHo
 ytYntTPuH0A1Rze58abRvVy8Ems2DKC2hzO5+xaP004iKzWIIMvzL43k5ocq0XDHinulUXxj
 a6Wcl8r9fOz6+j9ZbXmvJCcOolpgQ/9KqQjgsyyDfoiPgQTQ2SX5P6w2KDi8ED7WrlGkOU6n
 rfYvZzGK8kWo7O1DxNP3Ysi7huyDyuq3MkdkHQJMV5IfReKg5XpNlzIPfv1E/O/g0m3kDd32
 f/GJKDvApTML3fdiLrtYbBw4FNGxgUp19BQ/ZdUB6kBIP3tXk/xs8TVAAUlPgG02ejrFtRw2
 4wAVG2BHqOVLL7evUWP5uIyP+mDf4gVuCv7K/c4/fLulWU5mVgBfaa3wZQXdHG4HvNgI0mDZ
 nrsn8sBEWMNvgo5T+zmkkGNUTlWZ3qqXqI84C80CJ6+AIrDWIyhmqGN0DumEpFMe2xLC1KBH
 W32e4mcXvcDciOSIstvkjweUrihTpcs2g2utA/gyrpnNfbU+ioAtZLjytd5/enTmg8o9TxzD
 8WQyH2CT3p7nmMSQD82wbh/rVZjxVeeyaR4hedXGsRJ5/xVSgc6KYLcz+tiBtzvQg7BZMuGS
 E66QtW6BjE8Vs4+w9gSbElhGtWvlQvD3iqvA78NjbOHHp008qTG33jwPclx0XjG1LNyx2UhF
 +5OPm2vi6o32gzXCpTMmkPRw6OyeIwR2CrA7mKKyyyPsAdRTVg0GYDMR3MCfQP7qdrj50XNB
 +uLAK4kLxAH5MqMMKpMZfX2gF8ASPq1fJyUZ2O3hneoHR3Nyr6SRI7rYHkGmiLPDEEOiEYU5
 3nMfVw6ByG8s3rGB3liGEzHZ0L37fI4r2G/R0UviQaQYBsln/C29wQTiPjZSfoV364DojwJt
 Tp5BhC+0sjQBt7GoBBuNu0IYt4n5lpDkGDQsQ1hOYa7B75ti0RYcAltuU7qkRJtBdME2eEso
 X4xzEJRNKeRyhtiMQ3QiZn2N7DMKi/x4RWmcYbV10vY3dLQ/b0AvrBw4XPqogykEAIEtT1d2
 t4fmy+a74vHAQxUV9TrW0Ef8xl8uqGcYyM4oYjT0CsoeY+1uT/F39syTNMkxRmheZ8LNruFG
 wDzFeUVAsGvLKohnF3/PTweO+UH364uPti6cOOG1eaPMfxnjXryhmRd4Zth1VqM+mx4R/TPz
 r4O2P6C2RafETrh2gTy+vvrkJxJMGlBVlG0zjLpUcsIPvUalecjDG6vJ5by3dBin9v2XGYe8
 le/BlQA0cvveByIblW70xcDnV8PrymBni21hydxjylvtrCWiSfO2eX5aB0fOmMNQGR4ikbEK
 pO7ldcHRA6lclthjwOrsH7z3LMTv6FjNy/WSEZMcTLxKjRpUrGxraaFe85CrpclqyJGeO+nb
 kqdV6a7rgZJmzj7ET5mzSsgPyqvpo2/nxF+jzeFK21vqXPCZcxq7S/2ueSGG6J642JeHW9/l
 CXdAUW6M5+x59KImpzfs+e4EWW8SplUdiqtxoSF3MeizUttBxD33/W6m9m8VBM/zTe+zN5yE
 yPBsBf7ZIDvkaW8K+NuOEdyVhf67IJhF4dyn5FV5tlY0GUGhpiT4XsMkHviedRd16XkaXMRR
 DkNi9fL6Qnh0UdnIzqH3YX8Hnmax8JgYZG9bAZ0kmo279pLE7uT9LxJ2y94uF2phQnKbuJ6g
 y9bxOZvoH8WjucVuRY8mz2HC+N3fwEQNijtmhKUqtGm+fgNIj/3KP7pihU4x4PEbvnKuAxXV
 Xfnd413GCZx6p46K1fQyDjo7ZmiftDMbNUVvxnSkhHajuETJohi85hCzSdhJ2/5umUojuAhi
 hk7l5q6pomcN2J1/K//BhNCMSzdbNgc4DbwleBTg4zFuuLnVoUkATgNUJbyGLijECgTrujgL
 waDVjkxsHCKMbHEEhWY9V8gom+FQPXJfzmHYXIey9tlXhyUIkdS1RsVUDsNlZk8Dgm2xcblf
 S+V/xgp70Xj4ltJw+NsbFzkV3vH4RyvcnEyQYSeKxxf6kdD4V3UOIqQ9LA7EyZd95yn5AuDT
 w7TLw9IF2ASRkucB12lOrS04sjo+POXHO2jN73DfP2CpPdfWPGB2Z+0mtY8uW/Ub4PWYCYkV
 bUywS8hFThhFt7cmikTRiBfjC/LY8OB5V+99iBxssGj4aHuUQPr65GIDugaOtFu9haqxKabY
 rPKwn8hcHABiMxKnyytqvBXxlMZhiBweiP4FL0BsXWIV6fMgupMCAZdbSpvNcxO5qZ63w9XO
 MedhMmms9wwxvMzFVpBUkTs38+zYslfaWq9LlLcGEGTNLnAITDRxNDfarizU7pNlKNZqlfj3
 FTTW1+mJTmFmzTzAlqkMftNlz2cJBxT/oWwaBF8IWP4Q8jhdwX9PcI93lhUifUkw3jNM2AbK
 z11dUhA+6aR4S1vifJ6A2Vd73BhILrMi2OD4uLfMJpTrepzD3E+ibdB+HpjgegwjmkMVLlvl
 SDVtNIrv1y2jrzF1G98SBQX4jdT2NDX5QMzY+OBsMEHACuM/QpRvznITU1S+J09TIWo4v41q
 JCHlbqvemoYtYuMpY1EQZCTcZ7PMWJ9Y0OxRHiIU01dC2bsbD6XhlQDwqubriTH98Fj+Jaww
 MJcGPgHBDlXXrsbEho3RtVaecUuB2p2n+LD15xaoibv5BjJGpcAt8ieBKvLWKfhdG7C3+kcP
 0Nak/SldOFxfsX6wxIwMFAixdaTQhOCU4wV+X9qNlds8hcKrSE2T3VtiRjsMlr/uSZKR/Dox
 kVkhFMmObZ/s2q2qxI+Il6AzMcpuHE4gs6twTWYcTqqaby1QZkTEC3s8U44LpL8RQ9xKwy0h
 01tcjneFfpdiL5pdGYjjwG529MHAflHUahNewMd39mvTqgQiwoAgRj/nRYB4vbZA5x/kgdsa
 YSrs39LxwNkapgyOLDUI61KiFNXg8fs9mek2/swzwkXO0sWuD7IPndQ4QpRaOZgfWKh5aR05
 BaHmidfdWRETPcsrv9wtws8N+mG0yP8wutDJ0S2ZIn9Z+uSv2nNk9LNQ0tlixlOzhEcu+Eoj
 oF5IC/2Hwg1wbCcFgoEL5/HIABRNI9J8WTLOD2JqaPLyI50OIO0EqbpS/WPveAamBHBfk5hE
 oIS48AGBpTp3lvfKJKtJ74fyA4x4xzrKROBAe5OaTqAizgdpNynipJql9o4RHlVESBmPCO76
 6yC7Bctm+aGVcwqb20yZqJZDihoBOaHw3YA+XNdEDOwz+QVjhCY6CPxrTjRCz+6aMd/YPCTZ
 lVnD9T8qlBdu+CmzFXQ9JvZPWTzM99v78TO5e0trJGCE/pITLN5vhSUi8xCSnetSWKKDc+tK
 s26ddw3ddKtQCXfMBT3m3cvQsz2JtroMqWYnVSiW9NPqIfClDE7aZ3hTndPQVEo4blEvf80Z
 BVfMcZjJ0ew6EJmcfT4eVn9sJ3mQn7xe2YMCaAHlaPiIeQQlnZkb/fmmiJ4EtdmkK/vtxZKH
 c5CjwmAl6yqP9AMCHGqSHIBI12d921lxw0Dfq4z2rltmhqQ6AtFamnZerAxMz4W+I1tTVKKf
 ycsAzJhFQbF1NjNvlb3jeBKp3MPzZEJiIgn+DD/psGNOjv0Af7y8MyHvXZ4Noot+/UpY96kf
 5LOtYuAzGbWFMCC61TcAiDmT6EIlIAIeHAKB6QS0SQsPchM0WKkwUEqWd05OqQJBbR+/thCi
 BJcJHMql3FFfL7YhGVEhfqg0bzHkBvWaI4lLBEPrJRFhJ0aTjJyZSQd4qSkUteP/4drYmMQL
 x0U8BwK6R9Sz+dN
IronPort-Data: A9a23:TSaCbaAqEi3oFxVW/zrow5YqxClBgxIJ4kV8jS/XYbTApDol1mACm
 GIWXjvSPP+PNmP8Lox1YN/i/U9VuZHdydBiOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuHZzdJ5xYuajhIs/7a9ks21BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc5xLlXlX9xfNfMFknL64n4bl6Gzhq9
 dVNfVjhbjjb7w636IqSF9E22JgIEZGzZcUYp21qyizfAbA+W5ffTq7W5NhemjAtmsRJGvWYb
 M0cAdZtREmaJUQXYxFOVs14xo9EhVGnG9FcgFmVv6ss/2/LzAE31LX3N8v9cceFX8JIhgCVu
 woq+kypXkBGaYPCkVJp9FrwqPHWlzP0er4UTrKzp9hF2GCdykgMXUh+uVyT+qLj1hHWt8hkA
 0cT8SEvhbMj8VSiCNj7RRyx5nCe1iPwQPJVGuw+rQ+Xw6zf7g2UAHQeRzpIetsg7ZZuH2Ryj
 gXPmM71DztytrHTUWia6rqfsTK1P24SMHMGYigHCwAC5rEPvb3fkDqQbftNAaizv+HtCCPT/
 CvVoTJno7U62JtjO7qAwXjLhDelp57sRwEz5xnKUm/N0u+fTN/9D2BPwQiKhcusPLqkok+9U
 G8stfL20QzjJZSElSjITv8EGrqk7PuDLCfVhVd9GJ94rmz3oyb7J8ZX/S10I1pvPoAcYzj1b
 UTPuARXophOIH+taqwxaIW0YyjL8UQCPYu/Phw3RoMUCnSUSONh1HwzDaJ39z2w+HXAaYllZ
 f+mnT+EVB7285hPwjusXPs62rQ23C04zm67bcmklk/9iefPNSLFGOxt3L6yggYRvfvsTOL9o
 o43Cid240kFDbaWjtT/rdBMcQtadShT6W7e8pYKKb7SSuaZJI3RI6SKm+9+E2CUt6FUnf3P5
 XazRgdTz0Dn7UAr2i3bAk2PnIjHBM4lxVpiZXJEFQ/xhxALP9zzhI9BLMBfVed8q4ReIQtcF
 KVtlzOoWakXFlwqOl01MfHAkWCVXE/y1VnXYnb5PmdXklwJb1Whx+IItzDHrEEmZhdbf+Nny
 1F5/lqDGMZRdBcoF8vMdvOkwnW4uHVXyqo4XFLFLpMXMA/g+ZRjYX65xPImAdA+GTOazBuj1
 iGSHUg5o8vJqNQL69Xnv/2PgLqoNOpcJXBkOVfnw4y4DxSHwVr787R8CL6JWRv/SFLL/L6TY
 LQJ7vPkb9wCslV4k6t9NLdJz6lk68rl/IFF6gFaRVTKcFWZJbdyKVaW3cR0l/Nsx50InSCUS
 06w6t1hFrHRA/zcEXkVPxsDbMqP8do2iwvix605D2ui7RAm4Yfdd1tZOie9rRB0LZx3AdsD+
 vggsstH0D6PoEMmHfjehx8F6lnWCGILVpgmkZQoAIXLrA4P4XMaaLz+Dh7G2r2+W+9uAGILf
 ADN3LHjgo5CzHXsa3AwTHjB/dRMjKQ05Sxl8gUwGESrqPHk2NkMwxxjwRYmRF90zzJG8d5JF
 EpFCklXHZiKrhBU3JVtfmb0AAxQJgyrymqowXszqWDpZU2JVGvMEW4DBdiw7H0pq2JyQhUL/
 ZWz6nrUbjLxTcSgggowQRFErtLgf/xQ9yrDuvmeI/q8OpsLOQO8v7CLSUcVoUDZWfI01RTNo
 NB398ZSd6HUCywcjKklAYjHy7ggcguOfj1YZfRH4qkyPHr9fQuq0mOkMHGBecJqJt3L/3SnC
 sdoGNl9ahSm2AuKrREZHaQpMZYtuNIIvf0pZaLNN20dlrmQvApSr5Pb8xbhiF8RQ9lBldg3L
 qXTfWmgFlO8qGR1mWjfitttIUu9PMc5YTPj0NCP8OkmE4wJtMduexoQ1pq2p3CkDxt1zSmLv
 Q/sZ77k8MI68N5Cx7DTK6RkAxm4DfjRV+7SqQC6jIloXOP1aMzLs1sYl0njMwFoJoAuYtVQl
 4mWkdvJzUjA7acXUWfYpsG7LJN3x/6OBchZDsGmC0Nhv3qmeNTt6B496WyHOcR3sNdC1PKGG
 Sq8SuWNLOAwZfkM5Ud7SSZkFzQlN5/WdYbl/CO0kOSNAEMS0CvBN9KWykXqZmB6KA4NHY/MU
 S3qt8aH++JokYVoLz0HDsFAHJVXDgLCW6wnVtuprhieLDCirW2js4vYtygLyG/0GFjeNfii+
 rPDZBz1VCrqiZHy1NsD7rBD5EwGPkhykcwbXxw7+ecvrxuYEWRfD+AWEateO6Fuiiaoia3JP
 mDcXlADVxf4cy9PKyjnwdLZWQyaOOwCF/H5KhEt/GKWcy2GP5yBMpQw6hZf52pKRRW7wNGFM
 d0+/ljCDiq1yLxtRscR4aWfqsVjzfX42HkJ2B7cl+rfPhUgOogJhUdRRFd1aS/6Es/zzRSBY
 SB/QG1fW0i0RHLgCcsqKTYfBBgduyip1DkyKzuGxNHEoYiA0elc07vFNvru1qEYJtE/TFLUq
 agbm0PWi4xX5pAShUftk+oA3JcuV66gI5DidenkWBEYmLy25iI/JcQekCETTcYkvglCD1fak
 Trq6H87bKhAAF4Ew6WYkG3l5LooOk/gzRmQ5OI8mdMCuRciwMLeZgDswR+TxVTYtf34p0sBK
 NsNRB/5nrBV3QcIYRF1rfsBoUGfR8wMfZUBvubEUbuq+iqRpKRh+HyNHq30Ox+9MJGJ+2mMS
 Jus7g==
IronPort-HdrOrdr: A9a23:SmHUC6gttmNzrB7vDAcgXJqEpXBQX2R13DAbv31ZSRFFG/FwyP
 rCoB1L73XJYWgqM03IwerwQ5VpQRvnhP1ICRF4B8bpYOCUghrTEGgE1/qu/9SAIVy0ygc578
 tdmsdFebrN5DRB7PoSpTPIa+rIo+P3vJxA592uqUuFJDsCA84P0+46MHfjLqQcfnglOXNNLu
 v52iMxnUvERZ14VKSGL0hAe9KGi8zAlZrgbxJDLQUg8hOygTSh76O/OwSE3z8FOgk/j4sKwC
 zgqUjU96+ju/a0xlv3zGnI9albn9Pn159qGNGMsM4IMT/h4zzYJbiJGofy/AzdktvfqmrCo+
 O85ivI+P4Dr085S1vF4icFHTOQlwrGpUWSj2NwykGT3PARDAhKd/apw7gpPScxonBQwu2Vms
 hwrh2knosSAhXakCvn4d/UExlsi0qvuHIn1fUelnpFTOIlGclsRKEkjTdo+a07bVXHwZFiFP
 MrANDX5f5Qf1/fZ3fFvnN3yNjpWngoBB+JTkULp8TQilFt7ThE5lpdwNZakmYL9Zo7RZUB7+
 PYMr5wnLULSsMNd6pyCOoIXMPyAG3QRhDHNn6UPD3cZeg6EmOIr4Sy7KQ+5emsdpBNxJwumI
 7ZWFcdrmI2c1KGM7z64HSKyGG+fIyQZ0Wf9igF3ekJhlTVfsuaDRG+
X-Talos-CUID: 9a23:dImm0W3A5DigWadzdfZTsrxfReMIXGzbykbsO16qKllyF7CPEHuQ0fYx
X-Talos-MUID: 9a23:gDy/NQXGH+HSNs7q/GPCmihoJMhK36L0B0tct7pehseIETMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.07,205,1708383600"; 
   d="scan'208";a="84945750"
X-MGA-submission: =?us-ascii?q?MDES0urm5WiUwW7t3uZzvJ49F81RjjoEXcPE46?=
 =?us-ascii?q?w456uNhMFmgRAiXDBxlLg4piU49Hk9mA59ghP32oi4LW3IEvrhekVPS2?=
 =?us-ascii?q?zHBiJE5mG0V6CTB7kzhWeGOIWjHGvup9tq+3Q3KhoiM/wNNcwgLxVwQO?=
 =?us-ascii?q?MeD5LbvFNjkxex+I7KvKI3pA=3D=3D?=
Received: from mail-francecentralazon11020002.outbound.protection.outlook.com (HELO PA5P264CU001.outbound.protection.outlook.com) ([52.101.167.2])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 13:32:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMbtUzgkn+6WiMZdp2tSRQD6SqBqljQ2YEWLIzKySn+MF/7+6uo5tDL6Prj4OBkiaGHCQ0BgR2t2O7B4NTYscFmRA+h44NI6UbG8XVTSI4vbdiZ0m4NMJtYHhTW/e9HrE2/udxq4Jw0eI7BkdXgCJ/GSw//LmNuRpIQmjE2v9yElPQcxxHbgMPycJ9sRQQuxnU5AbIKveDaEqQwtU/XQB9i4mXSmXJoCimPdM5iMBpn2w2gS/gkttD/ORaGEuY8sjH12mDKANI7H7fBrYMsqLuTrumXpJd2pE7U7n/rTpAXEObNfr79hpbshyxUudPDjPAu/X9k6FBMuv8hW+VR4jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhsT3OsX+8+Dm7V8mu8l100PwluW1lC8VCNPSaNVky0=;
 b=T0XCTT3n5jm3DKPQr3xlbZETLCt2ntvqnc1C64FSBC9tXCM7mk7JV4sGG6eARkKB9dKxnFEpUotdKZlylLtypa1PjF05MZ1m3kgvxflA09CvK19UwX2Fu1SZR/gtSeVnQBOf4a4Kh/Il4iXOHcrtwLYfde53I89swsozgkpjLPXkyq/1Vp6T6uZbFBckKYScfYSQubx51vRoeE8hyIQ+LZQgTz55NRfwu3df4Vtd6u7ZlSHds/iJlTyzOLX7+sQ17aFWDGQI+BsMXpv9vP1Bq8OofFr5RRT5fT8wWYY+ybmKkNjoEPYZ7wbxeiB2jhBMf3mxPftVf4bHO0bunVi79A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhsT3OsX+8+Dm7V8mu8l100PwluW1lC8VCNPSaNVky0=;
 b=GHRa+JfGh7k7NWe/c+gqygy23KHLvm4BbPm08hK+CRvAFM/slCDlACIBnKqTEbmPyHJ8r4d0ag59qyW+7EpxDmV2Zckd3CRq5ttLbKbyp2gBRtKT+jReEon1fz/mH9/6S9JKw76QnM/mDgbw2PHIdFMbhY2KhHymoeIdE6JkWheUAwZaSmrH9AIcg9B6LTP4lPQLtWIsVONz2ihanz4rc6IzFyTDCS4vIVCaHfWn1rsOtSwZr1OYbAwU9LV9tZhwUBI+gzAjIBAh77B34FQvSPSysIL653bAC7bSHE5A1V6X5PI5jr2DgRg1K6WLYdl6Y+rFGRhO3ZWTHq2i2mFOCg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3594.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:165::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 11:32:51 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 11:32:51 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>, Markus Elfring
	<Markus.Elfring@web.de>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
Thread-Index: AQHajwiUZ49WFhSb3kyGC8qA5pa//LFqv4eAgAAGBwA=
Date: Tue, 16 Apr 2024 11:32:51 +0000
Message-ID: <795ca003-4231-45c0-8bb6-178597950fa5@csgroup.eu>
References: <7be66990-de9e-488b-ad6d-fafd1c7bb34c@web.de>
 <ee6022b8-3aeb-4e6e-99f5-2668dd344e0a@web.de> <87plupbm0c.fsf@mail.lhotse>
In-Reply-To: <87plupbm0c.fsf@mail.lhotse>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB3594:EE_
x-ms-office365-filtering-correlation-id: 28b8d700-6e3e-4981-5047-08dc5e08f352
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?cENsaDlRR3h4cHFwRS9TWHpEU3VObUMwWmM3R1VwTzhwb0xJaFhUNmNZWGpS?=
 =?utf-8?B?Y3BTM3MvaWlKalhhNUNhcWQ0emVDMEFDSzk3MkNjODJ3SHdxZTBHTlBMVS9H?=
 =?utf-8?B?aWZLNGRxdGhZTDNKVUhnYUJHRndlT1QySEhIdFRQY25acURNRlFrcnlCU1R4?=
 =?utf-8?B?K1d2VDBaUFYyV3M0Z01wY0lwSkFoZ0lsVHV2UVdPeFZuWHpsY0NuZnZIWEtz?=
 =?utf-8?B?c1FvMFpVUWNPRG1ERTFheThlTkx0RzJkdHlSdGlVcDdNclhrSDhhSDlReW11?=
 =?utf-8?B?Wmk0U0FOcDdTZDljQlMyWXo2c3RCYzVsZnk4TzBWdU5oYVZFanh3UFkxSFBE?=
 =?utf-8?B?Q3RySFVWZkZhMzduVUZ6RlE0a0NrNmlLOWRTQ2dZZWFlK1kyUkZwZDFwT29y?=
 =?utf-8?B?ekdGTlBGdm9vL21ZOGxVU2FHUUVHYlYrWDdOUXlDNlpILytzUzhUZHE5V0k1?=
 =?utf-8?B?c2ZyblNFeFFSV1FuNjQvekpzakVlSXhIVWdzTTBpd2xjSEQ0eDBCeGhLUU43?=
 =?utf-8?B?Y2JyY2VtUTdvejN1VHAxMjNLSnRUZzZ1b3B6MDkzRytOQkFBSU9ONzVRU1or?=
 =?utf-8?B?eDhlMmlBU1IrS2syTWJrVDhHOHFwVWJKckFOUjNWakE5L3VZc2tEOVdnemly?=
 =?utf-8?B?cVFtcTVOQjVnWFBsSzFxQ0FXNGtrOFJSRGxwcUFLalg5QmtuQWw0YXdHQTBs?=
 =?utf-8?B?eElnL2Z5M2hwODFPUUM4dUZqTkFycVFDUDFoRDlNSVBSbG9ja1R0Q1pDeTlM?=
 =?utf-8?B?b2l4VmJOc3piQURyQUdjUTFkQjN5TEYzNlhxbUdiWXZIdjFqQjBNNzNJZys5?=
 =?utf-8?B?U0JZdGd2ZStDTnVWNy9NTTd5NnJSdEkrczdjZmQwYzdDbVd6VGEzYXhLVGRa?=
 =?utf-8?B?ekk3dUtVZzVWd0t1Tm5VcTN6T2dVcitlLzlueWVmZXBlbkZQaDdHakl5UEJT?=
 =?utf-8?B?QUxYS2tuK1EzdGRGOWtiV3BjdTZKM2JPMUNXT20xOTBuelNNWC85SmF6NUU4?=
 =?utf-8?B?N1FPd2UzNlUvNEZrUnplb3ZDNWQ2dmhlS3lCdTc3a2pqSm84ZU4xSTExdTM3?=
 =?utf-8?B?MXRreHRFdWtSYXd6ZFJSZjRLVGxwcVR1ZlZaWnFGN0R6RUZCQnNWaitFWmo0?=
 =?utf-8?B?aFJKODlTamRONEJSbEw3ZDd1TFNQL3NvMmFGdm51RXZRT0dZc0JrWkk5WkVZ?=
 =?utf-8?B?Ni9FcHgzVytINVJCakt6UnY4VFo1TFpub2lQdE04eklNd1lLSVV1WkdCak9k?=
 =?utf-8?B?YzBacWpVVmVoSGdBNk5OWkhtZ3FBZGlEamR2S2hzY1lEbHBSemdFUEF0UE9P?=
 =?utf-8?B?dnpOaG1LVTBMTGY2WmcxZFJQZ2syd2dYbU12YTJLb0FCVUZEZGl4ZzdNK3Nk?=
 =?utf-8?B?WDZXb2xXdDRUZnpzWHZmS1JaWTg1SDNtWE1OQnYxK0ZLbllRLzI3S01XM3JD?=
 =?utf-8?B?THFoVm1UbTlUSUk4czZZNmJLWUxzeTFydzlWUVN3V2k5UE1wNXM2WkNxMnRO?=
 =?utf-8?B?V0U0WnplU0YwK1FTSUJSS3FtVkNseTQ0Vmw4TDZDenZQSm81N0tmanNaUDFr?=
 =?utf-8?B?ajRUSWdURDJsL1JzVEIySFBOdDJEcWNLOXBKc1dEM1VuSlpOVnp1R211d3BP?=
 =?utf-8?B?b2s3RURkd2tDOElQOGtqd0h3VDYwb1hDTURzWkpZcmpZR3Z0ckN2MVkxd2Vh?=
 =?utf-8?B?UzNPdkdWQlFCUGgwbHE4dDdsWHlTOFdaWlROUFkwRUlUVE5nZUNIN0JBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3FnMFBVaWtrZTFOUSsyNUFlOEt3eEpnY3RkcGRyRzVkK2ZCTFo4c3N0aTVr?=
 =?utf-8?B?dWFxdmNjVUQ2M241WlR0MGRaaEdLbWZzcFBUZUxmR2plQTNlOGpyWUYxejZC?=
 =?utf-8?B?YUIveXQrQTVyOHh6Vk9BRzFxcTFucHFRVlBLczM4ck4vZ2hsWTcyWThXZlJZ?=
 =?utf-8?B?UVZNVUtmZWxsTE1OSG53YXA4Q0ZMKzRpdEZ4dVhjQ1UxaS9HN1ZUeWlJZmIy?=
 =?utf-8?B?dldzV0cxdjgzeGt0aDI0UGxxQndzTEcrcTVYV0pNN3pUUkZDZk9QZXkzQ2FJ?=
 =?utf-8?B?dkpsMDF1dXdFaUxRdVN4UXFVb2hnZmIwRVJhSytCL3RXWnR6WnJHbEp6aUdv?=
 =?utf-8?B?ejVFNlJ2bUh3cTVvaVdlaXIra0I2aStzUUtGNDlvc09iS0VvTXAvQS91bE5L?=
 =?utf-8?B?cHE5WTlWMDgzR3EwaE1IVGYxWDhnR0Y4VE1WZUwrd3lBWWs1S1ZhT1poSXJz?=
 =?utf-8?B?UWxlYzdyTDd3R2VZdEhlaUhBaXBKbnBudStjSklVQkVqcDNDMXZOUWZlWTYv?=
 =?utf-8?B?UjgybVBUSFFjYXNDMUs3SE1UQm1EZnFXNFhnVkFtVDEzdEFtcGhuZy9Hd3Fq?=
 =?utf-8?B?SS84Mlowb3ZTL0ovUUV5ZHR2dTcrRndROTg3WGZ1M0RUSGFod1gvUklvWWR4?=
 =?utf-8?B?SlJ2amc0NmZwV3R4a1I4RWpyM2tIMFgxaXVpOEpkcC9mSVYwRzRqRlNRcHVK?=
 =?utf-8?B?MXBJNzBIMjZEN3doYk0zSjdDZTY0Y1lNdUliRXY2M0pScWV4Zy9CRmM0L2Iy?=
 =?utf-8?B?V1F5cko2T0UxZzZyRVpjb1NjZ2FkREh1T0l0SDlnWUJhcFRabG1MZS9iMm85?=
 =?utf-8?B?S2FLRDhRZTBOV0FNY0Y4c2svcmxzenhhUkFxUzJqNzJUNlFnc3o4RVMxMFlw?=
 =?utf-8?B?Q1BXRU1EZVN4SUlyeEtoem8rNitPZ3ZuU28rRjhHcjVwZFNEd3VsN1k2cVNx?=
 =?utf-8?B?UFhja01sSGJmdndXemowRnJJNGx6WUtvRnBIRlp4VVFhQ0s4ZStLTlNFUWNv?=
 =?utf-8?B?NFBjK1ZjTXBtb3ArQTVMQy9uTkxFTmw3WnVib0VETmtLS2FnZGZiOXExeUpp?=
 =?utf-8?B?dmdJYngvR3NDZFZLRWV4UnorM0pvTWRudnAybFVsckNmRUpnYzBuM2JMeTRl?=
 =?utf-8?B?Sjcrc29qSUR1bW50TUtkdEUvM0YrMjI5Y0RMcURQdHUrRS9tTURrZHFnMTlR?=
 =?utf-8?B?YTRjSnZkR3ZhVHRqaUxielowTkRlS2tNM0pOcWZjbVQ0OHBHS0FKTWRYNWp4?=
 =?utf-8?B?ajBlZTQyKzVvMWhkQlVlUGZPVTJUZThXaGhmMmphZGRjV2xOb2lUem9lUGtj?=
 =?utf-8?B?QmhMZzRUaEpkWmFqQ2ZxK1BYMis2Z1hoN2lxdEMvZ2czeUZxNTRRNHdNMmxs?=
 =?utf-8?B?WVVqVkZONmZibCt1bVRuVmpRTC9samEwYWpjQ3BtVHBCU0NXS2NBeDF4cUZa?=
 =?utf-8?B?MVh5OHloMXRzNGRBb1JrUmV3RUVXYkd6MzZnYlpSVWVOc3g1ZWJoNlQ2cXho?=
 =?utf-8?B?SHBxOU5JK3ZUcit0cUZtN0JHejJoSnVyUVhFZkZyMFpjZlZJVnBhMTRQL0J0?=
 =?utf-8?B?STdZa2lKL1lGd1llamxlajljcDZ0Wld0M2NXei9uMjdmNmEwNVRaWFQ5SnV5?=
 =?utf-8?B?RW1qM3FXbmU3ckNDa2dCU09yNkd2c1JDcHpFZlFPMHV0blp6RHloVlZMcmhv?=
 =?utf-8?B?VzlRbmRkOW1URDAxM2ZrOEk0SFRRa3lHYUlPMHFTTTgyQWJROGtVMU5ZYnYx?=
 =?utf-8?B?bDN5N0JPMmVQMmcrWWhTS1paWDR0bHE3d2UrTk5jMVFaRmMxL3gyZUtRRDZD?=
 =?utf-8?B?MkRacHlndUhYd1kwYzVmOWxaa1cwakVYYy9HUnJHWEZHNnZoNEt1ZXYwRHVH?=
 =?utf-8?B?eXJDeW12UC9oMXFRT1JLYzNRZy9vSEp3N05NcHZkaFhuSGg2cDlwQVhNMFQw?=
 =?utf-8?B?d21jdVJWazVvdTNsbVFwTHY0T0pjUEpVb1JhWDFUL1l6aFBKWDVacnJRc3pi?=
 =?utf-8?B?MnBRcmRGT0F1M0VFTEg3REc4K0FHdmpJY1FIaVh2cm4vZWZ6cGEwQ293ZS9W?=
 =?utf-8?B?S2hCNXNEL0Raam1RYjZOTTk5eWVsYTlNYkJnenN0a2swQXpFa3BpN29ORkdq?=
 =?utf-8?Q?F0JUGjz44CsjmYDLBuVV1QSLj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D212CACD369EB54DB7C35319BCAAF141@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b8d700-6e3e-4981-5047-08dc5e08f352
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 11:32:51.4562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i/GqTTcerK8Ta06jnfM2dpxO/XUYMyMtCPIFNMUCGPUx9rAe80eVz1w1BLCs4FiqgvrRGOcLO14pmMJlGdIYTkjozdT5akaOFuxmsghTW5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3594
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [0/2] powerpc/powernv/vas: Adjustments for two function
 implementations
Reply-To: Christophe Leroy <christophe.leroy@csgroup.eu>
X-Loop: cocci@inria.fr
X-Sequence: 1661
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-04/795ca003-4231-45c0-8bb6-178597950fa5%40csgroup.eu>

DQoNCkxlIDE2LzA0LzIwMjQgw6AgMTM6MTEsIE1pY2hhZWwgRWxsZXJtYW4gYSDDqWNyaXTCoDoN
Cj4gTWFya3VzIEVsZnJpbmcgPE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4gd3JpdGVzOg0KPj4+IEEg
ZmV3IHVwZGF0ZSBzdWdnZXN0aW9ucyB3ZXJlIHRha2VuIGludG8gYWNjb3VudA0KPj4+IGZyb20g
c3RhdGljIHNvdXJjZSBjb2RlIGFuYWx5c2lzLg0KPj4+DQo+Pj4gTWFya3VzIEVsZnJpbmcgKDIp
Og0KPj4NCj4+IEkgd291bGQgYXBwcmVjaWF0ZSBhIGJpdCBtb3JlIGluZm9ybWF0aW9uIGFib3V0
IHRoZSByZWFzb25zDQo+PiB3aHkgdGhpcyBwYXRjaCBzZXJpZXMgd2FzIHJlamVjdGVkLg0KPj4N
Cj4+DQo+Pj4gICAgT25lIGZ1bmN0aW9uIGNhbGwgbGVzcyBpbiB2YXNfd2luZG93X2FsbG9jKCkg
YWZ0ZXIgZXJyb3IgZGV0ZWN0aW9uDQo+Pg0KPj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9y
Zy9wcm9qZWN0L2xpbnV4cHBjLWRldi9wYXRjaC8xZjFjMjFjZi1jMzRjLTQxOGMtYjAwYy04ZTY0
NzRmMTI2MTJAd2ViLmRlLw0KPiANCj4gSXQgaW50cm9kdWNlZCBhIG5ldyBnb3RvIGFuZCBsYWJl
bCB0byBhdm9pZCBhIGtmcmVlKE5VTEwpIGNhbGwsIGJ1dA0KPiBrZnJlZSgpIGV4cGxpY2l0bHkg
YWNjZXB0cyBOVUxMIGFuZCBoYW5kbGVzIGl0LiBTbyBpdCBjb21wbGljYXRlcyB0aGUNCj4gc291
cmNlIGNvZGUgZm9yIG5vIGdhaW4uDQoNClRoaXMgaXMgZXhwbGljaXQgaW4gS2VybmVsIGRvY3Vt
ZW50YXRpb246DQoNCi8qKg0KICAqIGtmcmVlIC0gZnJlZSBwcmV2aW91c2x5IGFsbG9jYXRlZCBt
ZW1vcnkNCiAgKiBAb2JqZWN0OiBwb2ludGVyIHJldHVybmVkIGJ5IGttYWxsb2MoKSBvciBrbWVt
X2NhY2hlX2FsbG9jKCkNCiAgKg0KICAqIElmIEBvYmplY3QgaXMgTlVMTCwgbm8gb3BlcmF0aW9u
IGlzIHBlcmZvcm1lZC4NCiAgKi8NCg0KVGhhdCdzIGV4YWN0bHkgdGhlIHNhbWUgYmVoYXZpb3Vy
IGFzIGZyZWUoKSBpbiBsaWJjLg0KDQpTbyBDb2NjaW5lbGxlIHNob3VsZCBiZSBmaXhlZCBpZiBp
dCByZXBvcnRzIGFuIGVycm9yIGZvciB0aGF0Lg0KDQo+IA0KPj4+ICAgIFJldHVybiBkaXJlY3Rs
eSBhZnRlciBhIGZhaWxlZCBrYXNwcmludGYoKSBpbiBtYXBfcGFzdGVfcmVnaW9uKCkNCj4+DQo+
PiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbGludXhwcGMtZGV2L3BhdGNo
L2Y0NmYwNGJjLTYxM2MtNGU5OC1iNjAyLTRjNTEyMDU1NmIwOUB3ZWIuZGUvDQo+IA0KPiBCYXNp
Y2FsbHkgdGhlIHNhbWUgcmVhc29uaW5nLiBBbmQgaXQgYWxzbyBjaGFuZ2VzIHRoZSBmdW5jdGlv
biBmcm9tDQo+IGhhdmluZyB0d28gcmV0dXJuIHBhdGhzIChzdWNjZXNzIGFuZCBlcnJvciksIHRv
IHRocmVlLg0KPiANCg0KTG9va2luZyBhdCB0aGF0IGZ1bmN0aW9uLCBJIGhvd2V2ZXIgc2VlIGEg
bWlzc2luZyByZWdpb24gcmVsZWFzZSB3aGVuIA0KaW9yZW1hcF9jYWNoZSgpIGZhaWxzLg0KDQpD
aHJpc3RvcGhlDQo=
