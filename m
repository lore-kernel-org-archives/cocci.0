Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF608D68BDF
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7RgevXzVOF2wd0QHaqg8sKSXBh3tNnxEZNLAJYHO4/0=;
  b=PYbzVETzF8zjz0gqcr2Ffus5VmkOmlNYCRhwZZTT31xiGmt7VPZTR1bK
   vOevS8jU385I5ysSJP58tx764Hm0vtvXxnxrNZNzyAYgasIa/K5MvzV6H
   gFtcqsIdoyEXRj32699gOVv9ib0kJzrHbSwrBVl2oVkUOy8tZPlQiDoqN
   4=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194169519"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:35:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 710E9E0DF5; Fri, 15 Nov 2024 23:35:50 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 209BCE0D1C
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:22:55 +0100 (CET)
IronPort-SDR: 6737bbae_RiWc3XJGn7mKBIpJTA0DSKOJg9KFX+raTfa6yL8JmNjP8DC
 zm4nTdLpEcf+HdrknZz7Z41Ua/W7ufMbH8k5WOA==
X-IPAS-Result: =?us-ascii?q?A0EzAABAujdncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDgVczBwhIhFadZJBNgVaBQD4PAQMBTgECBAEBAwSBTIM0AopLA?=
 =?us-ascii?q?h8GAQQxCA4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAGBDIV7D?=
 =?us-ascii?q?YJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEBHgIBAxESB?=
 =?us-ascii?q?BkBATcBDyUCJgICRhAGARKDAYJlBgKfTAGHYAEBAosjfzOBAYIMAQEGgmfZO?=
 =?us-ascii?q?IFkCYEaLgGISwGBbIN9O4NCeicbgUlEgUqBBoIthAocMoNGgmmCRYUTJYUGg?=
 =?us-ascii?q?3mZeAk/gQUcA1khEQFVEw0KCwcFY1c8AyJvalN6K4ELgRc6QoE7gRMvGyELX?=
 =?us-ascii?q?IEpgRoUBhUEgQ5GP4JKaUs3Ag0CNoIkJFmBHYEyhRqEbGcvAwMDA4M8gk5kL?=
 =?us-ascii?q?h1AAwsYDUgRLDUGDhtDAW4HnwJGgzSBDpl7jUKha4QkoV0BMqpOLodkkGUiq?=
 =?us-ascii?q?FSCGQE4gVxGByMVgyJPAxkPjiGDeo8+AbYZQzU7AgcLAQEDCYVGAQGJWwEnD?=
 =?us-ascii?q?IFLAQE?=
IronPort-PHdr: A9a23:wbsnIx33lqiFnbUXsmDOZhMyDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeGo68xxwaVBs2bs6sC17GO9fi4GCQp2tWojjMrSN92a1c9k8IYnggtUoauKHbQC7rUVRE8B
 9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9I
 Ri4sAndrNcajIRtJqosxRbErGZDd+BKyW91P16ekBjx6tuq8JJ/7yhcvu8q+tJdX6n9Y6k3Q
 rtUASg8PWwy+MPlqwTIQxGV5nsbXGUWkx5IDBbA4RrnQJr/sTb0u/Rk1iWCMsL4Ub47WTK57
 6d2UxDokzsINyQ48G7MlMN9ir9QrQ+7qBx+x47UZ5yVNOZ7c6jAc94WWXZNU8BMXCFaHIiyc
 5UAAPYAPeZAronyuV0OrQelBQKxAO/j0yJEimPq0aE/1ekqDAPI0xE6H98WsHraosj7O6gOX
 u66z6fIwzfMYe1I1Dn684XIbhIsrOuQUb9qbcbcy08iHB7FgFWKrozlOiuY2OsXvGiA4etvT
 /ivgHMlpQ5ruDivx8cshZPTho0PzFDP6CJ0z5gvKt24UkF7e9+kEJtKuCyBM4t2Q8UiQ3xnu
 Sogz70GuIK0fDINyJQ8wB7fZeCHf5KU7RLkUeacODF1j29qd7yjnRi961SgyvHiWcmu1lZHt
 iVLn8fMu30M1xLe9NSKR/Vy80qg2DuDyQLe5+BaLUwpiabWJJAvz70sm5cXrEnOHSz7lVv2g
 qGZakgq9PSk5eThb777pZGcL5d5hhzwP6g0mMGyA/40PhUOUmWU4+iwyb7u8VPhTLhFkvE6i
 K3UvI3AKcgGu6K1HRVZ34In5hu5EjyrztAYnWQcLFJZZh2HlZXnO1DPIf/mFfqyglKhmypxy
 f/cJL3uGJDNI2DDkLj/ebZ97FZRyA4yzdBZ+pJVBasNIPfyWkDtrtzYCQQ5Mwu6w+b7Etlyy
 oQeWWeXDq+YNqPdr0OI6/oyL+SCfoMYujTwJ+I46/PugnI1g0IRcKq30ZcPbXC3BPVmI0GXY
 Xr2hdcBFH8HsRQkQ+zqklKCSz9TZ3aoUK8n4jE7CYSmDZrMR4y3hbyB3Tu0HodRZmBdDVCMH
 2voe5+YVPcLbSKeOslhnSccWri7V4AhzQ2utBP9y7d/MObY4jcYuo771Nhp++3Tkgk/9ThuA
 MWTyW6NS2V0k3gJRj832aBwulZ9xU2Z3ah5hfxYD91T6OlTXgc0L57Q1/Z6BMzqWgLdYteJT
 06rTcmhAT4tUt0xwsQDY119GtWnlhDMxTCmA74Tl7yRBZw76LjQ33brJ5U193GT7KAri15uZ
 MZOL2Tur79i7A+bU5bAmUGev6Cnaaod2DLA7iGE12XY+Al6VxxrXKuNfnkTYkbdttX6rhfBR
 rOqBL8PNAZdx8+GNqZQLNrzggMCDL3PMcrfbyqK3S+VBBKMy6nGJN7mcnsQ2Q3RAVYJlgQU8
 2rAMwUiUGPpjnjfB3RCCFfmcU7wub1zpG6+R1050ymFaEpu07fz8RkQ07jUafoQw7hMmyYqq
 jNvH1f1i9HLAdOopAd7eqhYJ9Qn7wEDnVrQsAh6drWqIqZjzgoGeg56uULGzRh7Coxc18Mtq
 SVuhDFzLKWemHNGbTaR29ikOrrNL3La/x21baPSnFbE34DSsoUS7PUx43HqowitEgJ20Whj0
 tAT93KD75HOJAsUS5P4FEgtoVwygbDRZS00/Mvs3HltIeHgtD7J3NYgH609wxKhb/9eNaqLU
 gHoRYlSK8GoKeEu032gZRFMaOxb8q85O+u0cP2fxaPtO/xvynburW1A4oF01Aq+9zd1TOGAi
 5YMxPOZ1w3BRTfhhVGums/ykIFAIzoVGzz7gRLjDoNLeuVQdJwZDGata5mtwd9znYKrWXdC5
 luiBHsIwsKkPxSIORi15xBLzkkTpTSEmC23h2hwkjc0voKWxinKwuL/ZFwAIGENWWo0yR/ML
 Im3iJgxVVKzcwUvj1Px5U3z76xaorlvaWjZRAFDeC2gaylcW7CxsqvKTMlV4pIr+XFYV/6UZ
 VGcV667ohEflSjkGj0ajBk/eiGjvJn0hVRVj3iRIXtt5C7QdsZqyRrS+vTYRPhMznwHTiw+g
 j7SUBz0FNmz/M6Ilp7F+sq5TWS9TJRefiTxhdeKszG9+XdjDBKyhdi3m9v6AU472yq93N5vA
 2GAlwjxZMHQ3KS8POZjcwE8H0Hx7dFSHoB4j5t2hZsVn3Mdg8PRtV0JkH27G9RHxaX4JC4KT
 z8X39nTyAjs0kRlJzSAxtS9HlKRz8cpSNCwaGoHknY64MlAAq6FxL9Jhy14phy/tw2HJbBZg
 zwU0rMC5TY/ivsCuAtlmiGACbkJW0VVOCX2nBSJx9G4sKhTIm2odO70nHZ+mtWoF/mirwVYQ
 2rj5JJqSTNw6cB2KxTM3Xn38Z3+f9z4adMVqw3SkhHcguwTI5U0wL5Cvy1rI2PyujUbyvA6x
 Uh02p2gvYeAbXts4qORAxhEOzmzbMQWrHWlqK9XhNqb2ciLF5NiGjIRR4egGfehGSgOuPKhM
 w+IEz07sGyHMb7eGxKPrkZgs3/LVZusMifTbFwQ3dRnSVGnJVRWmgxcCDAgn4YwDAyCx8H7d
 kp9oDcL6Qi84idMzedhLFHNU2LaqR2tYzEyAMyDPhtT6wxY4k7TN+SF8/l+WS1VqNnpgAWTK
 2DTTgVSCWAEEhiNBkrnP7SizdbF+umcQOG5Kq2KKY6PrOtYXr+2yI6z35Euqy2NM8KJN1FsA
 eI/3gxIXSY9U+bUgTICTWQbmmrnaNSAuF/o+CBtqc25/P7DVwXo6o+CTbBVNIMrsyisiLmOO
 ujYpy99KDlZ0J4ByX6AnKAc1VoThCBoejShEJwPsinCSK+WkahSWVpTUCN6Nc9F6a509QlEP
 8KT3sj13798g/g5I1hCUlPll4eiYslcZymUMl/dCVnDEKmAI3Wfysf7e66jCrtdkOlZqTW0p
 DCdVUTjaHDLtTDsWgvnCuRFlj3TaB5XvYymNA1oAHL/ZNj8bRS3O9hyyzYxxOtwzl/LPm1UE
 jV6dU5Bv/XE4SJTgbN8FmpH43Z0BeOenC+V5O7dbJ0RtK0vSm5WnudX+zwXjZkTpAtDWOByn
 S/fv5Qm93Ovl+SUjBBgTAZJrzJGlaqrtEN5NKPh/4NcX3ve5xIM9SObDBFc45MvL9T1p6FWg
 vuJ3Jr+NDpY6N/St4NIAsHONMOBdmIsLRfzAzPSJAwfRDWvOCfUgEkL1Lmo8XKYtNACo4Wkv
 Z0ITD4TAEYyGf4ATFxsAfQJIYttXyNimrme2opAx3e4t1H4VM9ds9iTX+KYBvjHKzuDi7RAI
 RcLl/ewDo0XMoCz5UVmbREun5rDH034Xt1XpCBlKAgurxMJuFpzQGN7+UXlbBiq5jdHF/yzn
 hgtjQ1WYuk38jropVAtKQyO7AA5jEA1mNOtpDmLcTj4N+/kVohKAi71sQ40O4n6RQ9uRQSom
 ApvMzKSA/p4ibd6eH8jrQjGpZxJUapVTrVBSBsRw+yHIvsvzFJQozmmwkkB4vHKX98qtgIhc
 taTpnRPk1ZhbdgtOOrPLaxG5lNUgb+C+C6v0OcqhgQZIhBJuEabYiUFvAQoMb06IiOu+KQ47
 AWYkDZHUGgLU+Yvq/RssEQnNLLEhwDn07dFYmC8O+aSNazR72rHlceOBFM92kkFjUZt8r1/0
 MNleE2RAQRn6KaQBVwgKMXfMh1SJ9RV8jD/cCCSo62ZxY90LcOxG+b0X8eBsa8VhgSvGwN/W
 8wj9MkOVrq210jYaOfuNqIAwBNlsAvxKVqGDNxNeRSWgDkAvsezxYN22o8bISsSVyE1HyGw/
 LfeoEcEifuFUdMyYz9OUI8DLHM/Xou0ki9fsnBEDRG9yOUQxAOF6nn3oSGGSHHGZssrRuqVL
 Ud2Csy30T8l9KG6glnStJ7ZIje+fe9pvcPTockArpCLBvUcGaJ3qU7al4Reb3awVGfDGtmwY
 ZP3bt9oJfbuDX+2WVu6wzMzU8rrOt+pZquFmwflQc5OvZea0S9rMc6mCnlKERx14uIO/qRxY
 UgNbpc3axfjtEE6NrejCA2C1dyiSGGobzBRSq8bhdW7erZQhw4tJruqyWYqSpAS1eS78UcRA
 poNi0eajdendoAWfTLiHXlaZU2bpCYjhm9kMfgazeI2wReOul4ZZXTDVutyaCR8uNA5D1SfP
 Hs+XmggQF6Zh43Oyg2hxbYf+21ahdkClaVnsWL/9rzYezOqUeT/q5TWtDEIbtU8paB1d4v5L
 Z3C/LbfhDvESJDO+ieIViOhX65fkNVWLTlwW+RTlCcuK5pC8bJM9VB5c8M3K7FMQP00o7SjZ
 TdnJTUP1iJfXISFinhKoOCxk5/TiQ2ddp8veEgGt5gEhtICSSNwaS42vqKvV4zK0WSDTz5Pa
 CUa9wNX4Ase3qxhZe3h6cKcVJJWxi5+u/9uXzuNHYs+sxPHQ2Kfmlj5ANS+mu3hiR5T0/vt+
 sIGQxM5Ak9YkaIeslYjIao/ELUZtY6C5jvObl/zt2LF0OagK0RN08rSdk2+AIeT8SLGTzYH9
 HkQDaxOzn6XQZATlRdpK6s3olxSIZ6Oc1z74z0i2pQvGKO3E92okRJthnYcRjy2EtNHQ85jv
 VPRVSctN5urspT+J5RbRClf/ZCcrVpDuEpoOi+9j5FbLpcJqhoLQTlU6Q2Qsd2pAJlH3tJ3F
 NkUL9p5oF/2H7lFN5mXrjs9vbm5jjf8+js8uVq+jBi3H6KiSutftzkbAggBKmCap1MqBu1q8
 2uU+02b9hhS/uxbAbyGlg1JoTlyH5YGUjBR1H+qLlJbQ3xPsuEcI6PQJYgUaPkoZASzPAQ+G
 LYC0laO7AkglnfjYjdusRNa9mbZUhMzRAEembj3niAG7My6b3tSbZtWYDgnJwGNEQuc0XRRt
 QhSZkdCWJ0DBNtBvbYB0t0Qtu/LRUalNygDFCd4NwQ5z/NEnEgL5ECRdSzMJQ6pc+vf9Bx9e
 IGaq8v/f9rj+wISp4r8r+kiv4UKXXymkBekR5iKoob8v8eLtkKmcKb+Lv36ZH7KVj/Xih6sw
 7wjCs+ZrGDoLANHJswimjIfap/7BDuOZEweT0p6D09SVKQhLM5DvvgffMh8PqAA5a5qABuDA
 BLpAo2m6vdcfR7IXTqLCSKH/6SkpJ7Lq6THQL3tb8yF3XfHSopzP5Fn+X/+Grzw1pRZ9Faw0
 fBopQthUVaTCymat5z6Ix8Tosyrd0/spJosSD7fAJ5qkXrk7kVBcdcHBSir+44f05RX9DD7T
 ucrmlPrvrhq/qJ/oZIy/6gvycqwIvLKLu9GtEZ8HhWOLgFr8Ig9Rm1+THpWeegfNLHaeqFxY
 dnGjefxGuRX7RSU/7ccct7bPwTandH5DDiASBtClQNHqDgALwLa2eTX06lzAd2oo+T0wCdPq
 xC3MwIGwbZx5IyF5rvApenZaAHUxKQFXa6iT936r7AlsUefrfM+k7tGdmtwagyhWO8TM6xVj
 mrpzakwzCIlO8fCGa/wvvtCXGg+hTXuh9Z2GFBXUvIYELyX/JhPy38ikr+8VJVeeaRDl2CTU
 B+8R+ZZjyH0rXLKfC880kudtnO4CXm+51L3syJiFC7FztO411FQSqHyHkBKGSygJU5/tjqLe
 gvurtv+/6ovvyRUeiTpssyAkGy5NfZZBcr6cZaRKCk9vlMXhbU1R9qyycYeGNGnJ8wW/m04Z
 fzboTDO8WcJs+JciozS79vAsPjeHXC6jq2Tg7GMwi1IjH05tks48deuKrfF4NjAEJHKny4BC
 ix4vQXGRRu8rLfW+ksVNUK820DOgIUWP9td0BHUz2ne7fM4CJI2/QRaTcPbYu8a4Cv0IH3yy
 EqeZNQ+Um+f1SFWFxT7CwswFK850WP29MXH8BWYs1AhRoBqdkzurRh2CZgob0cs40IQ2S0ND
 U4GbhXTALyzBEvjJJcJTgBaMlLYg/7jJ/txhB0pirq0gY2bJfRxHa8MKupQgkaVkV5XF4hX+
 awSTbRgekNMoavepwzsEY/iDLDtkXs9M+HwQ9gPqJtf6CRku1vjAUPws8Qmjf5Tkp2De69ab
 IKZucl96xwi/jsTbmlWhwA5iRqlUOcareSl497BsZPu5Pz9McRlD+gR6RUwAHxzypXqh1V26
 9ze1+5GS43coYD+9h1dZXuLs5zdyB5yNawFLIfhL9MCvz0XYjMTIX4DJ4/cZvA86jVsMDz74
 11EH9NKYNITJs3Wng5IzEbuXfsAk6iTUk/dAIB1eccy6mPxwz1g6powXNHr7zquLIze5VVAb
 LtTyT9hn9XYqK0J0OLfXWIJtGKBZUE/kUbgg9GdTuz99uKWxJTIWkMaS2QoBpxFKmPK+BT7F
 LPu0sq2FFrJtomq0Mh2MUuUQjbZcL0tiq9XCqYAjyz62mMbDYXpn7eOtMLq7mJLt1pBGYI17
 BvfGawZMI8pcRj/k8CqQAB7CE6dMInMcQEyveON2uoWy+F/MVbuI4oaKQgD0LX09TxeSQ4mR
 LPtv1mfVP4cf5M/E7Wb8TYMtN4mcv9VdFGGwf6i5i9FslU3HBMkZPcrozpWe1OP1AxZVqDou
 aIR3wsRVdkq8URIGG+2JCc//2+eDuIK0+/IVaBTq2XJHclsGw1yPyhzQg24wsBrcrqtxrVct
 39e2zh6uL4s2iBnQx21vWvtobgM0HQu4uLd1n1JtHpbQ+GZiyqNB09EyaFAgK4cAmzj6VWUZ
 HgFcZu05bhsP8P78oc9pX84ZF9wGk9OFfTlECz2g66SV8aXt8lAgReWpMjURbuyKzUCcLE8w
 gjkXH9zzk7VmxMiow5pCn2wqdQjIou6I8MswCGlTHPaeFg76aRMqMLttFQPQbh+eRZ7zW5ky
 MTCWjwVSZmFBTMulgZ9IzYhEtoL+VoAGqIvmDrNoqRW4lRefmLPCor8sojIwZWRgj9iEpEzm
 z6Q//3fztYj1Hkv8zuVxiqPvmkCMenZWNVrGX/9ysFUzumsPp1FV8gDSY172PKkUfQYNdKk9
 3fw05JvCBfNLls2G1u/Lf9Fw7bQSSC+TmOEH++MdjrV9ws=
IronPort-Data: A9a23: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
 wQ=
IronPort-HdrOrdr: A9a23:lvb+RKmKIMRLDYZCG3+fcyexl4LpDfIW3DAbv31ZSRFFG/FwWf
 re+sjzsiWE6wr5OUtBpTjjUJPrfZq4z/NICOYqUotKMDOLhILsFvAH0WKA+Vzd8lPFh4xgPM
 5bGsAUNDSzNykesS+Q2meF+rgbsb66GdiT9J7j80s=
X-Talos-CUID: 9a23:iOhOk2Ms3whV7e5DYiJt5mgqFpAfcmDM0m/rMR+1FHxPR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3ATknEIA8bgw8/YsSh8G2hWaeQf+s0zPmwOhwcqrh?=
 =?us-ascii?q?YmMqZbS5sNTSzng3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101770995"
X-MGA-submission: =?us-ascii?q?MDHfMe2TCxRr1NHD+aSmEjJGgJMLfXEC6+PTC8?=
 =?us-ascii?q?BTP3NWTkvIt4DziDQwYYqw/O+l73DU0X5GcfRFGQ0DLnwTtjXrcSlkRO?=
 =?us-ascii?q?oxxKyUret5zIhH3r8diW8yhncjj0egven4OapV/emanMUzrJoLXWSAHI?=
 =?us-ascii?q?S1AWXcTEXQRKm62g+byNjKkg=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 15 Nov 2024 22:22:54 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id C5D5B20BEBF7;
	Fri, 15 Nov 2024 13:22:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5D5B20BEBF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731705765;
	bh=7RgevXzVOF2wd0QHaqg8sKSXBh3tNnxEZNLAJYHO4/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LFvj1omrNM0zZtGffox7sgW5nc9dJZdVTA81Dj/wcPv/4s/wuIVOvUvfZbveDvw4y
	 FuotwM7kePQ1S+NtqBMYs5hCFuKfxjTKCfLm2hLOBes2vr8zw1wp6TV7hkDlej16jx
	 Fb+baeYINJlZ9BwwcItDzf5jhfC0bccWbyd+vUuI=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Fri, 15 Nov 2024 21:22:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-converge-secs-to-jiffies-v1-18-19aadc34941b@linux.microsoft.com>
References: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
In-Reply-To: <20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>, 
 Oded Gabbay <ogabbay@kernel.org>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Jens Axboe <axboe@kernel.dk>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Jack Wang <jinpu.wang@cloud.ionos.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Russell King <linux+etnaviv@armlinux.org.uk>, 
 Christian Gmeiner <christian.gmeiner@gmail.com>, 
 Louis Peens <louis.peens@corigine.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cocci@inria.fr, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org, 
 linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-mm@kvack.org, 
 linux-bluetooth@vger.kernel.org, linux-staging@lists.linux.dev, 
 linux-rpi-kernel@lists.infradead.org, ceph-devel@vger.kernel.org, 
 live-patching@vger.kernel.org, linux-sound@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, oss-drivers@corigine.com, 
 linuxppc-dev@lists.ozlabs.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 18/22] ceph: Convert timeouts to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2020
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/20241115-converge-secs-to-jiffies-v1-18-19aadc34941b%40linux.microsoft.com>

Changes made with the following Coccinelle rules:

@@ constant C; @@

- msecs_to_jiffies(C * 1000)
+ secs_to_jiffies(C)

@@ constant C; @@

- msecs_to_jiffies(C * MSEC_PER_SEC)
+ secs_to_jiffies(C)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 fs/ceph/quota.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 06ee397e0c3a6172592e62dba95cd267cfff0db1..d90eda19bcc4618f98bfed833c10a6071cf2e2ac 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -166,7 +166,7 @@ static struct inode *lookup_quotarealm_inode(struct ceph_mds_client *mdsc,
 	if (IS_ERR(in)) {
 		doutc(cl, "Can't lookup inode %llx (err: %ld)\n", realm->ino,
 		      PTR_ERR(in));
-		qri->timeout = jiffies + msecs_to_jiffies(60 * 1000); /* XXX */
+		qri->timeout = jiffies + secs_to_jiffies(60); /* XXX */
 	} else {
 		qri->timeout = 0;
 		qri->inode = in;

-- 
2.34.1

