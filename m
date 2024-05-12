Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7043DC10F1A
	for <cocci@archiver.kernel.org>; Sun, 12 May 2024 09:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FfR4h3P0BtQurg5Vl16XPRwiuHg3cZQRiP6MMK8dlMI=;
  b=ua9yEcmz76jDKTSi/A4EBbsTxSis7dk0Ls6nUECK2jh0YFdQYY0FZEjT
   UqtJ5CT/tT97cEsQIU/c3D0DXsuJE8n8CWH2kdvRJNlfrVWN3FT/7W/gW
   7ALHNin3WhfmNHhbBd2PwYVNQRThJ1RaNYv25W9+tbQnYwShbeuw+nJwe
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="165235009"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 May 2024 11:30:56 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D55C4E0AF1; Sun, 12 May 2024 11:30:55 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D7FD6E004E
	for <cocci@sympa.inria.fr>; Sun, 12 May 2024 11:30:51 +0200 (CEST)
IronPort-SDR: 66408c4b_womJl+MkL37tCxAD2oBVwPRVBb8dqR7Ah2FyuzAIP4tyk+Q
 AHXlV//Ru+naMuuZ5uGaH3t0TK7n0/RvJMebo9Q==
X-IPAS-Result: =?us-ascii?q?A0HgBQAti0Bmhw4P49RagQmEE4FUMwQLSIRWkT0whDuHO?=
 =?us-ascii?q?YdPiHGDFj4PAQMBDUEBAgQBAQMEhHUKAog9Ah4HAQQ0EwECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBIxcHDhAnhXQNgmcBEIEOgSYBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEXAkdCAQEBAgEjHQEBEScPCxoCJgICVgYBFAEBgnyCM?=
 =?us-ascii?q?AEDDiMHsk+BMoEBggwBAQbaWR8sIleBYwmBGi6ILgGFfIRAJw+BVUSBPAuCR?=
 =?us-ascii?q?zE+hEODW4Jpj0aKVoQ6WQ+CcgKII1R9HANZMgFVExcLPgkWAhYDGxQEMA8JC?=
 =?us-ascii?q?yYqBjYCEgwGBgZZIBYJBCMDCAQDEDQDIHERAwQaBAsHdYF2gTUEE0QDgTiJd?=
 =?us-ascii?q?QyDL4F1KYQdCENsFYN1gXcOYYNYhE5mgScdQAIBC209NQkLGwYiAR2mYYECy?=
 =?us-ascii?q?Dw0B4I2gWCBYQyfRAYTL5c4DgaSaJhiIKhngXwjgVwzGiRPgmdPAxkPjjqEF?=
 =?us-ascii?q?MsgQTU7AgcLAQEDCYVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23:zvu8Rx0w3dnBnllzsmDOnQ4yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaOo68x1hSQAM3y0LFttan/i+PaZSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNZwhEniSxbLxsI
 Bm5sAncttQdjJd/JKo21hbGrXxEdvhMy29vOVydgQv36N2q/J5k/SRQuvYh+NBFXK7nYak2T
 qFWASo/PWwt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WSin4
 qx2RhLklDsLOjgk+2zMlMd+kLxUrw6gpxxnwo7bfoeVNOZlfqjAed8WXHdNUtpNWyBEBI63c
 okBAPcbPetArIfzqVQBohWjCweyCuPhyj1HiWP506Ahz+QhCBvL0BA8E94QsnnZqsj+OqcIU
 eCyyanF1TLNYOlM2Tf+9YjIaQ0qr/6IXbJ+a8rRyE8vFwzYhViXroLqJSmV1ucQs2iA9eZuW
 uavi2A9qwFwpDivydwhi4fXiY0O0FzL6Dt2zZ8zKNalR0F1fcSqH4FMtyGGKYR2WMUiTnlpt
 Ssk1rAKpZq2cTYIxZg6yBDSaf+Kf5WK7x/gSeqcISt0in15dLy/hxi//1WsxvD9W8e63lhEo
 CRLn9vSu30P0RHY98uJSuNl80u/xDqDyRrf5v9aLU02j6bXNp4szqQtmpccqUjOGiD7lF/4g
 aOLbEkp+eyl5/7jb7jmoJKXKpF5igXjMqQ1hsywH/44PBUPX2ma5+uxzKHv8EvkS7tQlPI2i
 LPWsJXCKMQbuKG5BwhV354m6xa4EjemzM4UnHcZI11eYh6IkpbmN0nPIPD+E/i/n0yhnCl2y
 /zYJLHtHIvBI3rZnLv8fbtx8VNQxQUrwdBa/Z1UC7UBIPzpWk/2sdzVFhg3PBauw+bkFdV9z
 ZkSV22LAq+XKqPSsFmI5u00LuiCeoAaoyzxJOU76PL2i382gkcSfbO10psPdHC4AvNmLl2Hb
 Xb0mNcODX8KvhYiTOztkFCNTTlTaGquUKI9/Tw7E4KnDYLbRo+3mrCB3SG7HodXZm9cEFyMH
 23oe52eW/gQcCKSPtNhkjscWLilUYAg2wuhtAv+y7d8L+vU+ygYuon51Ndv/eHTlBcy9SZ1D
 8uHyW2NQXt0zSs0QGoUwaR+qARZw0iK1aww1/5FEd1aofdATQ4+MbbdyfZ7Apb8QFSFNtyOQ
 12natSgGzA4CNwrkPEUZEMoPty4jQ3YlweuDaUUkbPDULk96KHBxD7cI8hnynDJ/LYshR8qT
 50cZiWdmqdj+l2LVMbymEKDmvPvLPxEtMas3GKKzG7V+VpdTBY1SqLdG3YWekrRq939oELEV
 b6nT7o9YUNa0cDXDKxMZ5XyiEleAu/5MYH7aniyhnz2KBKG3LKKY6L1dm9b0CiOQFMcnVUr9
 G2dfRM7Gj/npmvfCDJ0Ele6Rkr28vRl7l6/QFU1yQ6icEBrkba4qVYOnfLJbfQV0/ofvTs57
 TV5GFHox9XNF9+JvBZsZo1ZZs4hpkhK3yTVumSRJ7SGKKZvzh4begVz5Ab10glvT55HiY4sp
 W8rywx7LeSZ1klAfnWWx8K4PLqfMWT08B21DsyekljDzNab/LsO4/Ukuh3iug+uDE8r73Rg1
 ZFczXKd4pzACAdaX4j2Vw478B1zpreSZSdYhcuc8HR2MrSv9BLG1cgoAuQN1RuqOdtSceuFG
 AL0D8wGFp22MuV501Otbx8CIKVT7PtuZpngLaHZnvf2er88z1fExSxd7Ytw01yB7X95Q+/Mh
 NMexu2AmxCAT3H6hUugtcb+ncZFYysTFyyx03uBZsYZa6tscIIMEWrrLdeww4A0opf3WGNDs
 nOnCUkH3sCBZheYKVDwl141twxfsTm8lC20wiYh2RQgtKmCx2rjx+r4dRwIEnFGTi9ugB2/R
 Or8x8BfV0+uYQ8zkRKj7kuv3KlXqpN0KGzLSFtJdSz7R417epO5raHKI8tG6Zdz9D5STPz5e
 leCDLj0vxod1SrnWWpY3jEyMT+w6N31mBlziWTVK3gWzjKRXMhqxgrEovHYS+RQ2DUuWyRyz
 zXaTlSxJNim+9yImoyL6LnkETj7CdsKLG+ykcuJr2Oj6HdvAAGjkvzW+JWvCgU83SLhlpFrW
 SjOsBfgc9zu3qW+P/hgexogD1v95sxmX4Bmx9Fp3tdKgydc38jTpCZU9AW7ec9W0q//cncXE
 DsCwtqOpRPgxFUmNXWRgYTwSnSaxMJlIdi8eGIfnCwnvKUoQO+Z6qJJmSxtrx+2twXUNLJYl
 y0e1OBoxXoUmeAPtyIywy/bDr1YTiw6dWT80g+F6dyztvAdQW+1cqWrkmd6k8qgCr6qvQxWH
 nr0MMRHf2c4/oB0N1TC12f244fvdYzLbN4dgRaTlg/Jk+lfLJ9i3upPnydsPnjx+GE00+Nux
 wI7xom05cLUTgcltLL8GBNTMSf5It8e6i24x7gLhd6YhsimTJBmBylNQ5biC/6lWDtAsPP6K
 0OeHjomtX6BFfzAEAXZ5EoDzTqHGsKuMGyLYXMe0NNpSV+CKUYZjA1cVWc/mYMlUwuxztHlc
 wEg7zYdvxjzrR4pqKogPkv6VXrD4QyzYTAuUN7GJRxat0dJ4EKdJ8Wa6qgb8zhw2JqnoUTNL
 2WaY18NFmQVQgmfAEilOLCy5N7G+uzeB+ykLvKIb6/c4epZH+yFw56iyO4Et36FK9mPM39+D
 vY6xlsLXHZ3HN7ckikOTCpfnjzEbsqSrhOxsiNtqcX3/PPuUQPprYyBbtkaec1o4AyziLyfO
 vS4gSFkNXBH25lKyXKJgLkT0VgOij1/IjmgFbNT0EyFBKnUm6JRE1sac3YpbZEOtfhjmFAQf
 5eH2baXnvZig/U4CklITwnkk8CtPokRJn2lcUjAHACNPaiHIjvCx4f2Z7m9QPtelrYx1VX4t
 DCFHkvkJjnGmSPuUkXlFOhWjzyAejFatpu8dBlFFmXpCt7rIE7eUpc/nXgtzLs4i2mff3YbK
 iR5elhRo6e46CRFnrNgFmYH4ncvfozm026JquLfLJgRq/5iBC95wvlb7HoNwLxQ9ChYRfZxl
 UM6T/ZrpEy61PaCwHxrXUgWwt6krJ2GtwNuNPeAnnGlcWnJ9lQB4DfIYyk=
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:/kqh2aOM6Z2U/sBcTh+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7NJGRbyeDn/QK/D9Es+9Wf9ru07N2utUuFATsKV0l6hT0Jcjpz/3cGPzWvjvcCfq
 ah2g==
X-Talos-CUID: 9a23:QG4KaW2KooMrQFs2w9XVTrxfAZgGdVDP1l3qG1KAE3ZKE7PFe1KJ0fYx
X-Talos-MUID: 9a23:Wi6dUQnu2eC7ZpcoN6sWdnpibediyKO8AnoJmLZYmpO5ZC1dGm2k2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,155,1712613600"; 
   d="scan'208";a="86797109"
X-MGA-submission: =?us-ascii?q?MDGTSX/yM3vygjAQZz5LkPMIrXrjFCwJCyFxnQ?=
 =?us-ascii?q?ZhgmLSe9UABiQK3pS/RCQqRcjIWElLhgwFoetltDpfiXNGzZnNUu2nij?=
 =?us-ascii?q?idAQttFYx8g5bOZJwsJQKkA4A5tUCh3kbZP1EUkftpZKeLIyJbCFfBQM?=
 =?us-ascii?q?nZQ50Fe6gjD3gLB6ygvBwmXw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 11:30:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715506250; x=1716111050; i=markus.elfring@web.de;
	bh=FfR4h3P0BtQurg5Vl16XPRwiuHg3cZQRiP6MMK8dlMI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fhqDIkkgDh81FsOB4JlydYbpWNIFZiOl+7CGxHMxxkikju4zIbM2994RrwxdqKSv
	 bJomVEgdJHoIZCR4PmQgb7nondtXgFsnLDq2CoAxMTFeRz83HxtVs5JqSjkQxCorL
	 SULO9WxfdjHbQkDtWTEfOKqxibONcDP8Q2upVkZmUIwqUnmiA2SH90u3gs1BvR45F
	 MxIgOo2EZPukIHiw+T1RY15gneu/1o6ANNGVucBdgfrKGgs5TI6oxzFMNvkZMWriy
	 rmu/1OT/nrxB3VXPqM+vi3cOd5D53Nr1uDtghsewNj7nf431HhyhJhnPbsJk30F3e
	 BQf05gTYT8LCO5ZDdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSZI5-1rzrKl1PGj-00T8gC; Sun, 12
 May 2024 11:30:50 +0200
Message-ID: <76bfe0a4-50dc-4169-b02e-79b3fe7bdd0e@web.de>
Date: Sun, 12 May 2024 11:30:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <bf850b64-b4bc-4738-9086-43018b8fbe93@web.de>
 <52305da6-998c-273c-c4cc-b8fdb1d161b@inria.fr>
 <6f5533b1-cbf8-421e-8d7d-8435aa28b360@web.de>
 <alpine.DEB.2.22.394.2405111803140.14453@hadrien>
 <c26d41ba-7d55-402b-92a0-5c3d4112893a@web.de>
 <alpine.DEB.2.22.394.2405120932360.6747@hadrien>
 <bac7cb07-aac0-4fb2-b524-3f53f8109a68@web.de>
 <alpine.DEB.2.22.394.2405121009430.6747@hadrien>
 <3db2d501-d95d-40c7-8ac1-1ce8c3bd9340@web.de>
 <alpine.DEB.2.22.394.2405121114580.6747@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405121114580.6747@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qTnYYgO41we0FuZHQJ6ZuoSEnnA6Q2XYt/uCJlsD9crBDAoAcWb
 NDHPvcJoXOj5BHQj9aRO55bBmzqBtbTampGtAcgSZx5yRXsJP282tEcp/A5tSBb6XiVLHkE
 6urnlcpSMdb8ZkMYsTLuTHz69Pvk6oag2LVhR84f7Wa5KCmQ/wX0Xu4XkHZauBDq2baPKh4
 2q0BG+ZLXrwFSIF5ZC6Aw==
UI-OutboundReport: notjunk:1;M01:P0:GyXst5Qz6ik=;ziW001Lu0MRWyNg+dgmrKQFw/q8
 D7nQBpFV6D+yVJAqM4Ti+sQjaLG7FdKdVon5zQK/eKxvETK/1uB7TbvVD6dmdr1HE+xRv/pwC
 5dDYFBxwDryMlmc/dxI090ePREmHitEoLRDHUhxMnB5buQzhg477wAitsuvFMzm6CidrdaPF1
 hCto0ubswx8CZ7w7ZMloDI7cqdAolaScKLq7R0ygCKiUOT2jHqOZK9AsNNcBW2CWwNmu/2n5c
 kxkR8cggH7EEkpm2t4wfOW25WmHCfbfh9gNYNNr8MfWCm4lWcS5Tk9NAsxQ3VJzMLdmodIibl
 fjsn543mVVVW25zQwyP406Az2xKEkZK8nDnhkoJvvqDyv7ZAKdnrSWYJIQPtXo8XLjPGNzWoO
 aucPzkQlWBEgTGs7Q2wJwymgK3Y7IXp45JLBaeIILW9r84gX+IaLL8gtROJ8wDWd9w1YvDgy0
 Xk0SU/IEHXzFX/HjPP3qOqXf8RBE9xe5tXMbwMyww0gD5bG9eD619oFT43bi/UVzh1KXdENED
 wI2oD6KY6xaq51BDtmwyBSNBKcMErMHpVk7NRv4jCfwvbkjAHU+OmdCVUfLOw23eyI942w6x4
 w3rw7afYN9ihImZP6RnLCI6QG4eO83dmqeL/ukrU7y4S7KNYSI6RLn/HxiD4d9jmDV0HQDXcz
 dFSILclTlrX8a2qAZ6/ox8fKLDiZfMquowRkL8jmvZTA2gbRXwsc+8e23XhGO5SYVckj1Iktr
 SOTR5VKHGCgh26dy8dBB3uvnXqCR4gaWmCkv2TKNwDZ6pSDbFnKtFtEt73IOsVjG6R6tNG3UH
 QZheMKXPw5ZHn6FegDT5YI3VYxY61+8fqe9qR9s1b/aJ4=
Subject: Re: [cocci] Searching for repeated source code with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1728
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/76bfe0a4-50dc-4169-b02e-79b3fe7bdd0e%40web.de>

>> I expect here that specific source code starts a known statement list.
>
> Coccinelle takes a pattern expressed as a CTL formula and every node in
> the control flow graph and tries to match the pattern at each node.
> The matching at one node is independent of the matching at another node.
> If there are conflicting matches that result in conflicting transformati=
ons,
> then it generates an error message.

Do we stumble on conflicts for more desirable data processing also
according to involved computation tree logic variants?

The mentioned nodes should occasionally mark the beginning
and a corresponding end of a code sequence.
Will code sequences (as statement lists in the discussed test case)
become better supported in the way as known units (or building blocks)?

Regards,
Markus
