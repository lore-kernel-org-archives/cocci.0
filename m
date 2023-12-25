Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2420BC3DA6E
	for <cocci@archiver.kernel.org>; Mon, 25 Dec 2023 17:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=jCNmKWsu0CzCXWmokXMMJ1bARHH/2ErBHLCDYhxE+nM=;
  b=LvTjQqfqj2Ny6oSR2tL4hViRG/X2y3Ndenu/s9B76zqPotPr4TLqe/EK
   X9GLEWGXQGdinYu81OFzTglRW7MfpMrjzvofakRmje4t9zmlpEMZxXKqD
   vohtsFRQvKNSMGYv0a6/oPAfEvbAArqCYPvB77Ubhn5i6dw5+CSkv0DtN
   8=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="143990061"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Dec 2023 18:42:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 87304E0CCE; Mon, 25 Dec 2023 18:42:36 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B79D7E004E
	for <cocci@sympa.inria.fr>; Mon, 25 Dec 2023 18:42:33 +0100 (CET)
IronPort-SDR: 6589bf09_OKqzkJLnDqpPnL66sE3XoQ6KDAITIfEbe2p/g+hdc66nbeW
 yuvc5GE7OduqL0f4kC4FP1nAJdQrxMxV5S8C8Jg==
X-IPAS-Result: =?us-ascii?q?A0FZBQAJvolle07ASNlaHgEBCxIMQIFEC4I5gVIyBAtIh?=
 =?us-ascii?q?FOPQYF1MIQ7hzWHTIRrhASBVoFAPg8BAwENQQECBAEBAwQ4hEcChzYCHgcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEkGAYOECeFb?=
 =?us-ascii?q?A2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCR0IDAyMdAQERJgEPHwEFA?=
 =?us-ascii?q?iYCAlYGARICAQGCfIIrAQMxB68kgTKBAYIKAQEGgmasch8sIlaBYAmBGi6IG?=
 =?us-ascii?q?wGFZ4NBeicPgVVEgRUnC4M2iB6CaIkcBzKCHINPkVl9BUFwGwMHA38PKwcEM?=
 =?us-ascii?q?CIGCRQtIwZQBCghCRMSQIFegVIKfj8PDhGCPiICPTYZSIJbFQw0BEZ1ECoEF?=
 =?us-ascii?q?BeBDm4bEh43ERAXDQMIdB0CESM8AwUDBDMKHQshBVYDQgZJCwMCGgUDAwSBM?=
 =?us-ascii?q?AUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDFADbB8yCTwPDBoCGx4NJyMCL?=
 =?us-ascii?q?EIDCQoFEAIWAyQWBDYRCQsoAywGOAISDAYGCV0mBw8JBCUDCAQDKykDI3QRA?=
 =?us-ascii?q?wQKAxQHCwdSAxkrHUACAQttPTUGAwsbBj4CpkuBDoJ2xQE0B4I0gWCBYQyfK?=
 =?us-ascii?q?wYTL5cmDgaSVC6HUJBPIKhGgWM6gVwzGiSDNk8DGQ+OIAwWhAmPCQE9QDU7A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBg1qBRgEB?=
IronPort-PHdr: A9a23:PWXjExDk1wsbIVtDi0wIUyQUQ0oY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua89ygWTBs6Cs6gMotGVmp6jcFRD26rJiGoFfp1IWk1NouQttCtkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhEmjmwbalsI
 BmoowjdudQajZd8Jq0s1hbHv3xEdvhZym9vOV+dhRHw6Nuu8pV+6SpQofUh98BBUaX+Yas1S
 KFTASolPW4o+sDlrAHPQgST6HQSVGUWiQdIDBPe7B7mRJfxszD1ufR71SKHIMD5V7E0WTCl7
 6d2VB/ljToMOjAl/G3LjMF7kblWqwy9qRNh34HUYZmVNPtgcaPbYdMaXndKUsJIWyBcHo+wc
 44DAuwcNuhasob9vUMDoxiwCwajCuzh1z9GiGHo0K000esuDQ7I0Rc8H9IXqnnYsMn5OLkQX
 O2z0aLGzS/Db/RT2Trl74bHaAohofKRXbJrbMHfxk0vFw3fjlWRr4zlMC6e2+MKvWeB9epgV
 v+vi3U9pw9+pjivyN0siojPhoIa0V3F+zt2z50vKdKlVkF2eNipG4ZfuC+GLYV5WN8iQ312t
 yYgzL0LoZC2cSsOxZk7wxPRZfyJfoyK7x/hSOufLip1iXF5dLyxmRu/8Eaux+/iW8S63ltGs
 y5InNfCu30MyRHe6daKR+V780y82jiPzxje5v9ZLU02j6bWKYAtzqQtmpcXr0jPBC37lUbug
 KKSeUgo4Oal5/n9brjlppKQLYt5hwH4P68zhMG/Bfk4MhMSX2eF4+Syybzj/EznT7hSk/E7l
 LTSvorAKsQBvKG5BhdY0oY95Ba7CDeryNEYnX4aLFJZYh6GgZbmNErULP/lE/izm1WskDF1y
 PDaJrDtHIjBI3rZnLrjY7px8VNQxQ4twdxF5Z9ZCakNIPfpVU/wsNzYAAU5Mwuxw+v/D9tyz
 JkeWWGSAq+CKq/cvluI5uw1I+mNYo8Vty3wKvY76PH1l3M2hEEScbGv3ZQMcH+4BOhpI12FY
 XrwhdcMCXoGshIkTOP2kF2CTSJTZ3GqUq0g4TE0FJ6pDYbYS4C2gL2B2T+7EYdMamBHDFCMC
 3boeJ+eV/cCciLBavNmxzgFU6WxDoIt3BqGqgD30fxkI/DS9ylesojskJB26vfVmBV39zVyD
 tiayXqlUW55hCULSiUw0aQ5plZyjh+p1rJ5mPhRC5Rr6u9KVRlyYZTE5+V+Ct30CkTNc4HNA
 HSvR9i9SRQ2VMk8i4sMakNwAJOniQrY0gKjGbpTnLuOUth816vBxX+5DM9n1X/C1K5ppFkrQ
 sJFfTmjja5y9wHZL43EiUOUk+Ctb6tKmGb3822O13bGhkBTUBJ9S+2RR2oebWPVoM7/60eES
 KWhX/BvDgxH2IamN6BJIon1ilNXAvP+M9f2YmStlmP2DhGNkPfEXYP4dmNV8yXUDk4NlkhH7
 H+UOA54CSeopWTXCRRnEF6paETpp7pQsnS+G2o91QKXdAVM07Sv+xgazai5QukQw6lClSMvs
 TRyE36i0tiQB9fW9FkpR7lVfd5ouAQP7mnerQEoe8X4d8iK53YbegVz5Ab10glvT55HiY4sp
 W8rywx7LeSZ1klAfnWWx8O4IaXZf0/1+h3ncKvKwhfGyt/D364V6+kj7XjnshuoEEUK7Hhtl
 dVYgDOH/pufNAMJStrqV1ovsR1zprXUeC44sqbdz35xKu+ZtjHY2tQmLPQowFCscoQXK7uKQ
 Sn1FcBSHM2yMKoqllyuOwoDJ/xX/bUoMtmOcvybxOi0MewmkD/OYX1vxod73wrM8iN9TrWNx
 JMZ27SD2RPBUT7gjVCnu8SxmIZeZDhUEHDtgS7jTJVcYKF/Z+NpQS+nPtG3y9NihpXsR28Q9
 VitAEkD0dOofhzaZkL03AlZ30Aa6XK9ni7wwztxmjAv5q2RuU6Gi8HrbhkaIShmQGd4jFHjC
 Ze5hZYWUQngbgQkkgek+Vev37JS9+x0K2jeR1sNfjCjdTg9FPTq8OPTOYgQuMBN020fSum3b
 FGER6SophIb13imBG5C3HUgcCnsvJzlnht8gWbbLXBprXOfd9sjoHWXrNHaW/NV2SILASdij
 jyCTH21Jdq05pO5k5nZs+axf32sXNtffGO4qOHI/Dv+/mBsDRClyrqWk8fkDBN8/Cv1zdhsW
 g3XoRy6boShhMHYeap3O0JvAlH78c9zHIpzx5AxiJ8n0n8fnpyJ/HADnA8fKP1j0LnlJDoIT
 D8PmJvO5RT9nVZkNjSPzp74UXOUxo1gYcO7ayUYwHB148dPAaaSpLtK+Ek96n+xtwHMer5Qm
 jkHyP0hwGEXiacFtUIhwz6cDbYbAURDdXa1yFLXtZbn/f8ROzbneKP4zEdkmNG9ELyOx2MUE
 G30fJsvB24478lyNk7NzGym74jlfNfKatdA/haQkhrGk61UMMdrz6VM2nAhYDOn+yJ1mItZx
 VR00Jq3vZaKMTBo9aO9WVtDMyHtItgU4nfrhLpfmcCf28auGI9gE3MFRsiNL7rgHTQMuPDgL
 wvLHic7ryLRPLPFHhKErmpioWjOFZ+DKHydYnUUh4YHJlHVNAlEjQYYUS9v1LswDAO334rMd
 Elj5zYezkH1oF1Ax6g7Unu3GnearwCuZDAuTZGZJxcD9QBO6XDeNsmG5/5yFSVVrdWx6RaAI
 WuBa0FUHHkEDwaaUkv7MODktryiu6CIQ/CzJPzUbfCSpPxCAr2WkIm33NIu/i7QZJ/WZD84V
 aJ9gxAdGykjS4ODxlBtA2QWj36fNZfB4k3mpWsu84bnt662EAP3udnVUuEUa48wvUnpx//Eb
 bHYhT4le2wBidVTnzmRmeJZhgJCzHs/ElvlWbUY6XydFuSJxPIRVkNKLXs0bpUA7rpgjFMUZ
 oiE0JWvjuE+1rlvVB9ETQCzwJj2I5NQZTjsbhWZWAHRatHkbXXK252lMfn6EOMNyr8O5lvp4
 m7TEle/bGTZ0WC3Clb1arkK1nvTKhVavMvVng9FL2/lQZqmbxS6NIQyljgq2fgvgWuMM2cAM
 D96ekcLr7uK7CoejO8tU2pGpmFoK+WJgUP7p6HRN4oWvP13Ay91i/MS4XI0zKFQ5T1FQ/o9k
 TXbr9pnqVWr2ueVzT8vXB1LozdNzIWF2Ccqcb3e7YVFUG3Y8Qgl6GKNF1IVqtEjBtCu86Fcx
 97Tlb7ifTdP99WHmKlUT8PQKc+BLD8gKU+zQWGSU1FDFG/xcz6P1Ck/2LmI+3aYr4Y3sM3pk
 ZsKEfpAUUAtU+gdEgJjFcADJ5F+WnUll6SahYgG/ynbzlGZScNEs5TATv/XD+/oLWPTqLBeZ
 AYTh578I54SMILTxEFoLFV31teveQKYTZVWryttYxVh6l1K62R7R3Yv1ljNbwSw/DkMGPTyk
 hN82W4cKaw9sTzr5VkwPF/DoiA9xVIwldvSijeUaDftLa20UOm+6gLxsFUtdIz2SUB5YF/q9
 aSBHCjJTfRdguk4HYiEoBDRs91DFKwFJZA=
IronPort-Data: A9a23:JwSyn6+hcvxWdECc37BgDrUDDnuTJUtcMsCJ2f8bNWPcYEJGY0x3n
 DQcXjyBbquNY2WjLdAjb423oBgBsZDWz9RrT1NsqCxEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHPymYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzA3f7nWYoWo4ow/jb8kg25q6v4GpwUmEWPJingneOzxH5M7pEfcldH1OgKqFIE+izQ
 fr0zb3R1gs1KD9wYj8Nuu+TnnwiGtY+DyDW4pZlc/TKbix5m8AH+v1T2Mzwxqtgo27hc9hZk
 L2hvHErIOsjFvWkdO81C3G0H8ziVEHvFXCuzXWX6KSuI0P6n3TEgNd1FGwNH7Ek3PtQWjx+p
 KAYb2lXR0XW7w626OrTpuhEg8M+MI/0MYlZtnwIITPxV695B8+ZBfybv5kHjF/chegWdRraT
 +8Qczlyd1LtZxNVO1EYII0zlqGkixETdhUH9QnP+/FsugA/yiRb3uHQc9z+UOXXRO4KvGeVg
 EX54XvAV0Ry2Nu3jGPtHmiXruTIlij6cJkDEaWxsP9smlyagGIJYCD6TnO+puSlzFGzUZRTJ
 iT45xbCs4Bx1lezY+LfYyGevVnf4y5NB9oXSrcTvVTlJrXv3y6VAW0NTzhkYdMgtdMrSTFC6
 mJlcvvsAiFz9qKYQzSR+994TA9e2wBEcQfugBPoqyNYvbEPR6lu0HryczqaOPfdYifJJN0E+
 BjT9HJWr+xL3aYjjvznlXiZ2GjEjsaSEWYICvD/BDnNAvVRONb6OORFKDHzsZ59EWpuZgDd5
 CVbw5XCs7Fm4FPkvHXlfdjh1YqBv56tWAAwS3Y2d3X432XzpSyQbspL7StgJUxkFM8BdHW7K
 AXQoA5drtsbdnejcaY9Mcr7BtUI3JrQM43vdsnVSd5SPbl3VguMpx91aWCqgmvCrUkLkIMEA
 6m9T/qCN3ghJJpC8CuXXMYYiL8i+TA/zzjcRLf91BWW7oCdb3+0F5YAaUWCXtkk4Pm6oSHQy
 dJ+NtSL+TpbQubRcinayq9NDFEofFwQJ4H6lNxTTcGHejFZIWAGD+TD5J8QYKl3tv1xusaR2
 V/lQW5e6l70pUOfGDWwcno5NY/eB8dun0w0LQkHHAiO2UF6Ra2N8a1GVZ88XYd/xdxZ1fQuE
 sU0IZSRMM9uFAbC1S8WN6TmjYpYcx+uuwKCEgylbBU7fL9iXwb5wcDlTCS+6BgxCjeLiuVmr
 42Czg/7Rb8xdzZmBuvSa9OtyAqVlloZk+RQQUDJA4dyfGPBzYtUEBHy38QHe5w0FRb+xzWhx
 1m3BzUcrrLzuIMbyoTCqp2FiIaLKNFAOHRmMVPV1puMDhmCzFGfmddBdM2qYQHiUHjF/fT+R
 OdNkND5Hv41vHdLlIteSIRU7L8MyObug5R4zQ1UOmrBQHr2K7FnI1iAhdJusI8UzJBnmAKGY
 GC90fgEBqesJ+XeD083GAopSs+hxMMksGDewtptKXqr+RIt2qSMVHtjGiWliQtfHeNTC5wky
 +Jwg/wmwVWzpTRyO+nXkx0O0XqHK0EBdKAVtps6JovPoShzw3FgZa3sMAPH0KutWf5tbHZze
 iS1gZDcjYty3kDBKno/NUbc1Npn2Kghhkp4808gFX+oxPz+mf4F7D9A+28WTyNU7Cl9/cBdB
 2xJD3BxdIKyp2pGpc4bRG29ORBzNDvA8GzL9lY5vmn4TU6pa2/zEFMAKdu9pH4+zWYNUQVYr
 Ze5yXnkWwnEZMve/DU/cm87pu3BTe5ezBzjmsemE567Hr0/Wz7Eg7CvV0UMuRDIEcM8v2yZh
 OhIrcJbS7z3Cj4UmII/U7Kl7LU3TAuWAUB/WtRjwf85Jn7dczSMxjS+EUC9VcdTLfjs80XjK
 chRCu9Qdha5jgCikys6APMSHrpKg/IZ3toOVbf1L2ogsbHEjD5IsorVxxfull0QXNRivsYsG
 Lz/LwvYPDSrukJVvGvRoO1vGGmyO4AEbTKh+tGFyrwCEpZbvdx8dU037KCPgEyUFwla5DORg
 hLIYv7H7u5lyLk0pbDWLId4O1yWJ+/wBcOyyyLig+QWOJmLeY3LuhgOo1bqAxVOMPFDE55rn
 LCKq5js0FmDoL8yVHvDloKcE7VSo/+/R/dTLtm9OUwycfFugyMwy0BrF6GExZ11fBd14866W
 02nZcH2edN9txKxApFKQ3A2LvrfI/2fgmTcSeeVsPmGTBQQueACBM3y7mfnNAm3aQdRU6ATy
 WbIVzKG+d1S6ohBbPPB6zeKHLcgSGLetWAamxEdeNVW4qREQr9Ph1c6qScd1A==
IronPort-HdrOrdr: A9a23:fMf/SK3GfNR28Fa18tIYOAqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPjUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyWMbEQt6bHCWeDYrMd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3A7RXZD2sKS3Td/iGsXIrwvkLi6ItmUGbF4UzyH3O?=
 =?us-ascii?q?eFEEyFY3EFV/XoflNxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ac/mPdA50I5AI0UAv2NgtGNrJxoxC7f2TS0Ymu6x?=
 =?us-ascii?q?buuLbFw19HRCikiuOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="75326331"
X-MGA-submission: =?us-ascii?q?MDEJotjDaky7jI9Euw3AuEaAudZH70WBgJvrgL?=
 =?us-ascii?q?pRJRgLYcGo5X5QYIaFMkob4HQCRHRCJdkRxBnJKy4/H3k3I8KCzC9H8b?=
 =?us-ascii?q?/zMSoBjuUke53cTK8ztX++cYJ3KZfmozrFryCGZNbR8ENfA1XbqdQV5o?=
 =?us-ascii?q?W8sj/qUp5fhFJZutVrPPjMlw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 18:42:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703526136; x=1704130936; i=markus.elfring@web.de;
	bh=DN1DZ8Q4gr5JZBxx9y14h9ITgGHp31mL41Pkj2olJ1A=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=GUGCLXGK50GeUpvRJtg0JnwjPvlj9KjLdZ6hnHgCZ7nV6QgNCMmrcpzpwAQ70Ol7
	 qO5R2gtqkc1MNHYTdwh7d631z7rgPuH2OicMr6JTF90SXOG9dLzxaT/JfmECvkJ8n
	 +0mXs/5ehrzdTNqomfoAgwGC75lvL2pKxtYdyxt7mokmr4xuIL79ohwQ3iIEyBYcD
	 bv9ryRjlgYqFi+ShqU8vXjnryXZgF3Bx6RraD0a2Ac4H2IeSRg/WW2aeyVQuGTRS8
	 NH2qxhdbeSThfunmlodBXo4K3C1c1ULC1iqhOTD0sqeW4py2h7F6AG+MAk8RM+/dH
	 xmVAZbuSnYkTz+9Ikw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4eGT-1rAHrb34j9-011WsV; Mon, 25
 Dec 2023 18:42:16 +0100
Message-ID: <8ecc9bd5-9001-4844-a3ea-f2b522a73cd3@web.de>
Date: Mon, 25 Dec 2023 18:42:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Muralidhara M K <muralidhara.mk@amd.com>
References: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
In-Reply-To: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2mmKeyB1681GDxQi1sKnPOxPX+IaW+IkMgtER2YiMnejmtGjbMk
 3Ko4EESXm92JaHnCN2m0nvkIeD/9+qCD+PJ9jEuMQFRWqwRgx9ByNpHoyRtd04L46Zb3wRx
 8tOs7YLcV+gQktydVjndK5GQX9qI3SopK+lN2So6YhhfQavedtD+5w3lBQZQlf5FXXlZ8JP
 y4KJGoSkRArEGQ/wJuD7w==
UI-OutboundReport: notjunk:1;M01:P0:DHtw6zTu/ns=;qWnu/Dj6l7S/ReZRUeGYnZubsgz
 alUOx57ZHhmLeJNK3u+AxhyisQjpXkeYOr6Gk7Z571mItKHhBpGwrNi8hyJERGTCZOoo74tyn
 XxlyWNa2uBWxaYlboMZyHOZA3myfX7qOurv1LV4JKj9UeSClXSm762HBvIqzW03e0YRAwrPJo
 9RO5Ds4F6U52TZ/tzrfojla58eW+qLPlwJy0FENYXfA14+nZefXeivvyAXhHtPkSRR6nje5Fq
 NKA7RSZaO+IZJJFIG/Q3NmB7g+t7kh7uWR2ENHwolyNC1Cj+3lymkqVd/PcLqptQScIHi3h8O
 ePASCHgyQHiTW9wH170nnayAtHFkUApWmPFfx1wAFnJOkbiBVjvjN3xlWmGJWe66EZuQ2Jlsn
 ytZcneh96QyDJr0OgSZFMjZcL0cJ+O2vGTcfSBXxzwQIucogVgAlJbTbr6i3KdGfMwdeAsc3m
 0fO8qO7dR88x2fpB/VcxflEXabc3CLC+RtwTKpkR4/sPEWII1dlGxwIsh/A13oupumo2LNmVO
 t48TTbPeZISVqp9P8VcIpb7WsVeh/y0DCf4Jb2pAD5eOZvmZZfjXZgGHYSOv79Z8wZGSC/vyu
 tJgfBmMZHQdheZA3Txh5l681+c4OcDEGaKUI5eNRu5ShvlwCOD8cNSDJLyK6itGTkZdVgi6/W
 GyA46ziiIrgBci4qobkuYwcqOXVl1mhj1Lw1WMj3FgTfm/2v8MJLbCRIGu79Pljgoc9BK5dam
 JttUoHilFg6GBKKd4jvxqXP3OEMwX5xWP6EjpxwsQk/tTv2z5hj1lMWVhneS9kw97rdluJVf6
 IHUQM4vSFqaqolLsxdf8niYTzHpbUIydjqkZZcrTRC6DjwaEauwFzkOxjft37bqSicfIqThyr
 qp6eK8wrRm8pNkINAZ5EutPoVfwQbJ71wXjOUQ2BXQkSv5LS/8NyAWA6V/5wkZrV6UyNSoiKu
 oI0Sky7sHiQiGaCKjaiv2bUrz1s=
Subject: [cocci] [PATCH 5/7] EDAC/amd64: Improve two size determinations in
 probe_one_instance()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1389
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/8ecc9bd5-9001-4844-a3ea-f2b522a73cd3%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 17:24:37 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator =E2=80=9Csizeof=E2=80=9D to make the cor=
responding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/amd64_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 64680de47cab..7536236df542 100644
=2D-- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4268,13 +4268,13 @@ static int probe_one_instance(unsigned int nid)
 	struct ecc_settings *s;
 	int ret;

-	s =3D kzalloc(sizeof(struct ecc_settings), GFP_KERNEL);
+	s =3D kzalloc(sizeof(*s), GFP_KERNEL);
 	if (!s)
 		return -ENOMEM;

 	ecc_stngs[nid] =3D s;

-	pvt =3D kzalloc(sizeof(struct amd64_pvt), GFP_KERNEL);
+	pvt =3D kzalloc(sizeof(*pvt), GFP_KERNEL);
 	if (!pvt) {
 		ret =3D -ENOMEM;
 		goto err_settings;
=2D-
2.43.0

