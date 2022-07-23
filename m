Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE978C433EF
	for <cocci@archiver.kernel.org>; Sat, 23 Jul 2022 05:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3ZdL8JMeusYUCnjUU4P/+1TTNYjBpLxYTOYbom2HTOA=;
  b=rLjt4sC1FHOIig/x8z73l2YJpVNJVC8jPTziqcZUY72PV/mlrtr8xRGa
   v/9xZ8SevYAsgUnw9x7v4wrXR3rb2EPgpJjZEboFPKzcjhrS3iSaBB4uw
   jPgfBI1OKmHfYeiSenxgTLQK1jneZW0fwOwj8E976g6+/fqKtnmHPMkPu
   w=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,187,1654552800"; 
   d="scan'208";a="46645129"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jul 2022 07:39:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8CC3BE0261; Sat, 23 Jul 2022 07:39:05 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BACD9E0260
	for <cocci@sympa.inria.fr>; Sat, 23 Jul 2022 07:38:59 +0200 (CEST)
IronPort-SDR: Sw+k9gXYN8h3U1JB8BxrrWpZYK9r2agOJpKNt3KUondjKX1RX5FaluAuwJqIvHVNyBDyqjAlDy
 tV/Ka+6wviftMhuqrP6B+GBJN1Sz8R3gh4vuZSI6NF0XqeVMxaIiSsJROEXh1ZEj2jnvfJHBfQ
 xk6OZo3P61422rfZN93tEYmKcssjBlvTTBH/A9c6M/Ny4fX3UzAM1YUHNHibImxbvNRYhp0E7c
 3JWykGG47HD6yQGvnSlQXmkigkgfI/LmFYgfEJHNqDkHs+oZXLyCzKp/dYuohSd+khrszt4JWu
 BrABHypuV/BOVZtfAnIWXGKk
X-IPAS-Result: =?us-ascii?q?A0BrAgBViNtihwwR49RaHgEBCxIMQIFEC4IkgQFWLgQLR?=
 =?us-ascii?q?YROkF0xhCSOLYYohXwLAQMBDTcIAQIEAQGCEoIvRQKEawIdBwEEMwYOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOEAU2Bl4GZ?=
 =?us-ascii?q?ASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBBAsLGgImAgJXBg0IAQGCeQGCZ?=
 =?us-ascii?q?AEDDSMHDKoVgTGBAYIIAQEGgT8Bgw0fLCJSgVwDBoERLAGPECcQgVVEgTyDA?=
 =?us-ascii?q?z6CYgKBYINWgmWcYiYEDgMaLS8SgR9sAQgEAwMHCgUuBgIMGBQEAhMSUxYCE?=
 =?us-ascii?q?gUPGQ4UGyIXDA8DEgMPAQcCCRAIESUIAgMIAwIDGwsCAxYJDgMdCAoYEhASA?=
 =?us-ascii?q?gQRGgsIAxY/CQIEDgNCCA4DEQQDDxgJEggQBAYDMgwlCwMUDAEGAwYFBQEDG?=
 =?us-ascii?q?wMUAwUkBwMfDyMNDQQbBx0DAwUlAwICGwcCAgMCBhUGAgJOOQgECAQrIw8FA?=
 =?us-ascii?q?gcvBQQvAh4EBQYRCAIWAgYEBAQEFgIQCAIIJxcHExgbGQEFMicQCSEcCgQaC?=
 =?us-ascii?q?gYFBhMDIG8FCjsPKDM2PCsfGwqBFSorFgMEBAMCBhoDAyICEC4xAxUGKRMSL?=
 =?us-ascii?q?QkqfQkCAyJxAwMELC4DCSEfBxkBGwKcZ4M/IoIbwSM0B4IWgT6BRAyJUpRhB?=
 =?us-ascii?q?hMtg2SSdA4GkXuWfIlVg2OVdYQngXeBfzMaJIM3TgECAQINAQICAwECAQIJA?=
 =?us-ascii?q?QECjh0Zg1kzii0/NDsCBgEKAQEDCYVHAQGJPQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:YO4VJ6mqFtwelqDVnR17e9Do5gyCIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIYUWjUM6qLMWL2eoogb9ni80MOsZ+EmoQwGgZqrCthE1tH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTrSs1hlZHWeIcg944f5Ys7N/09UAbeSRWVvX4
 4ut+ZaHYTdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1/6pC+FAwiA5fdmeUgeQZSMCZDerx/reqvzXiX6aR/zmXDdGbwhepjBgc6MOX0+M4tWDsIr
 6ZHbmlSKEnZ7w616OrTpu1Eo805L9Tweq4btGthyz7xEvssB5zOK0nPzYMGgmtt35oedRrYT
 5I2dhBTcUvbWCRKZl4VULU/xsKh2XaqJlW0r3rM+PZpujGNpOBr65DmN9Hee/SRVMBNlwCZo
 HjH9iL3GHkn2Me3zD2Y7jSzi+WJkS6TtJ8u+KOQxKFmjgCYzVEpGRwXaHGkq9q+twmvYocKQ
 6ALwRYGoa83/U2ta9DyWRykvXKJ1iIht8ps//4StVnRk/qMi+qNLjdUHmERADAznJVuHVQXO
 km1c8TBKREHXFe9aX+c8r2Ztyi5OSUUIQfujgdZE1dcubEPTKkJjh/OSNJqFqLwttP8HSOY/
 txnhC05mqlVksMBkam2lbwmv95OjsiWJuLWzlyGNo5A0u+fTND8D2BPwQaChcus1K7DEjG8U
 IEswqByFtwmA5CXjzCqS+4QBryv7PvtGGSC3A4yRsV/rG3yoi/LkWVsDNdWexcB3iEsJm+BX
 aMvkV8JjHOuFCb2PPEsOepd9exznPe4TrwJqcw4nvIXP8QvLVbZlM2fTRfehijsllQhi6cyJ
 d+Sfq6R4YUyWcxaIM6Nb75Fi9cDn3hgrUuKHMyT50n5jdK2OSDEIZ9YYQPmRr1ot8us/VSFm
 /4BbZfi40sECoXWPHKImbP/2HhRcBDX87it95cIHgNCSyI6cFwc5wj5kO57JdI6z/0K/goKl
 1nkMnJlJJPErSWvAW23hrpLMdsDhL5z8iA2OzICJ1Gt1yRxaIqj9vlNaJY9O7UqrbQxwflxR
 vgDWsOBHvUWFmWZoWtAN8GlodwwbgmviCKPIzGhPmo1calgcAqVqNXqSQ3iqXsVBS2tuMpi+
 LCtj1uJQZcKSwl4ItzRbfajkwG4sXQHxrBtUkGOLtQKIBfg941jKirQiP4rIphQeEuZmWbAj
 16bWE5Kq/PMrok59MjyqZqF94r5QfFjGkd6HnXA6ejkPyft/l2lnd1KXtGOcG2PT2jz4qijO
 b5YwvygYv0KmFFG79h1H7pxlPts4tzyu/lFww4iEHiSNwanDbZpI3+n28hTt/QRl+ED5lbsA
 hqCqotAJLGEGML5C1pPdgArWeS0061GkDfl6/locl7x4zV6/ebcXEgObQOAjjdRcOl8PI8/m
 L5zvckL90qghxBsPtvf1nJY8GGFL3ohVaQ7t8hGUdGx1VdxkglPMc7GFyv7wJCTcNESYEMkF
 T+jgvaQjbprwEefIWE4EmLA3LYGiJkD0PyQIITu+7hUdhv5av4LMNl59DMqUkJKwx8B3+8b1
 q2H8aFqDf3mwtuqrJErs6OQ98VpGxCTvED8o7fMvHOMVFGmDwQhM0VkUdtgPyklH6Z0YTVRu
 r2VoIogvfAGY+mpthYPtYVZRzAPgDC/GsAuWCxqIihdI6QHXA==
IronPort-HdrOrdr: A9a23:iD9LBKAt1oaZPozlHemI55DYdb4zR+YMi2TDGXoBLSC9Afbo8v
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QEZSWY+eRMbEVt7eY3OD1KbcdKMLsytHSuQ4y9QYWcelSAZsQkjuQgWugeHFLeA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,187,1654552800"; 
   d="scan'208";a="46645128"
X-MGA-submission: =?us-ascii?q?MDFwSktIyaKvsBnlzdj9zx1xWW8UscQYIUwHw9?=
 =?us-ascii?q?xrk5OPmhlk89hpbkkh1/4Q/TnuDgjxjwgeGqp16I9hfmCYKInvnXuZXy?=
 =?us-ascii?q?6+7ybHpsv6HXaPUVSYRqkweKvF+2K4KxuGo1NdFiqCsm2USa04oWJ3MG?=
 =?us-ascii?q?bEtuhrYBipQLlOBPOb8JbbtQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 07:38:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1658554737;
	bh=3ZdL8JMeusYUCnjUU4P/+1TTNYjBpLxYTOYbom2HTOA=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=rDU7lxQCXGuRBbR/hHgr1ZsWCzACgarOr7mLnd0ZlDc462WsafrFCysR0AAaA3I4h
	 StKnXUWycE1zMwXzuhVk5fMNj7iv+daMOduxtruM5zxpjRXj3FIFud1kCZsO8WmxZv
	 /HiC5ih3ayk/k0qKK0LSoYFH5ifyNNiNPhkkk0Pg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.133.171.49]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUU6E-1o6Qef0UzY-00Qstv; Sat, 23
 Jul 2022 07:38:57 +0200
Message-ID: <7aa4c8e3-22c2-f80a-6ad9-bcb2dd350d6e@web.de>
Date: Sat, 23 Jul 2022 07:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
To: "Richard W. M. Jones" <rjones@redhat.com>
References: <20220722192327.GA28597@redhat.com>
Content-Language: en-GB
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20220722192327.GA28597@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:whVQy84tEOjh47Ca4Oh1G8SXJ0VSPpEVJbuejJFmkeDBH22MuJP
 BdwiGL4NjCQ6ovkApBLjwdbwYQreyi7HmUGZc9f113uijiPQn0vFhJlTJDFr3iFEpbyHNkH
 tfaQMXKHdS1ZN2ZLQhLc7yVHoe5ZDegBZc1OEwVJP/BfKArdKV4H+F2c/O3eruCFtL9cFv3
 eu82/+9oDedFb0zsp39pA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nKzZ7Ol1SS8=:Bp4ZEO87NyTT8nAb2eJwjz
 aDblJRAOyt3CBd14DUgvbH5cuqVtr+HJW0UGcad0Alt4l5X9MDpvlQQiAa2+eJilL2qLIMAxA
 sq2JEp0kCV+MmGnKSvHgj5Os5AZioy4wYB9o60UjyBFJY7DuLZCmi3t3dG4JWxj6lVjsItcli
 7O8gNlxhMbdJY54nO4hFE776tfxLP5Hc32zRB71bXi9KFwXldkWEZhg9dEbL0vvOVUlY1A1HR
 eepP7IePzWOqLZjKK0FQvk1AspYr2wnVqquMfQJ+hlpmEQo+HUOkHOr1qQomjE7+Ln3Pl6PW3
 Pz4abLN26ppyNxktX3vF9VKViUNhH94LYDsKX0nwyKOWpy9OlkJO5aoX8YeoJmj+ZKFTPVwX9
 n7ZopQqNcd2BfMbETMBaJ3b72XtxUCEjR+Y0FoNbu62vdJDty1y8oY1BxBC8UxS1iy4GYicfz
 eyv7zgmCKfStzRoUMHGmmTQnNzbxqUGSE87Zk74hmbiGrVnD9Pz6an5UKZAZDu4bAOjy4FcwN
 S1WvQHvTbNPj/5DK+c0OuLGZjH8tqTNtZ7s6ragqRVM/nN9cMwIJrUEDZBTPPzj5x0UG2CNgH
 GCk9XvNxIjncNRBHIYrs1LYt4b/17Xs0OMYfQqYCZyRovJM6wWnQwXHUZWGOkYzHbCgq1V3+6
 hE3wtF05K1XGQjyrVVXA3p9OGy9XBBlNIo/RFkFdLJpDFXFwA79J9BlvbVCtXpKQFlLvlly0w
 CaiehvoKsOUd5Y3R6HXWmqApMmuFldGqYtg6n8ShSwNI0yJtlQl3qdEt4J0YZm2yRqGLgYytz
 o4rziJ/WJxnZ7d0Zv5fAIY56OCYtwtf2ITFgN+fGex+dPON3sTnrd13j36q2jjSBf7JmZdyAf
 PJHGvQlhYPcpIF6g4JygczvOPOeZ5wE6QZ1M1uGLXXpmOskimJn+/8FAjQr8+SFll/7FdQbkB
 VlS/EjddhkrJn6jlV+FxzKprV4ayRYKWD2kt+JwxcqePdC/uebOMr8iYPgjIWik0dpOtFUAv0
 sVZ9NxZk73fhcOnSP5fBgejPziscRfvmL+tdAMi1SlIAwxHDFSDAsGffQ87EpjWW9hLxNaCZM
 JTl9GzFWjeHAyfnFx2yQrq12A34yT8VI++JfVkPAg9y1OEOi7VMWPMRRA==
Subject: Re: [cocci] pcre vs pcre2
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 499
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/7aa4c8e3-22c2-f80a-6ad9-bcb2dd350d6e%40web.de>

> Does coccinelle plan to move to PCRE2?

I suggest to take another look at previous clarification requests.

Examples:
* Building the software for PCRE2 usage
=C2=A0 2018-07-17
=C2=A0 https://github.com/ggreer/the_silver_searcher/issues/1257

* Support for PCRE2
=C2=A0 2016-11-09
=C2=A0 https://github.com/mmottl/pcre-ocaml/issues/10

* Configuration possibilities for evaluation of regular expressions in SmP=
L constraints
=C2=A0 2018-11-20
=C2=A0 https://github.com/coccinelle/coccinelle/issues/149


How will development interests evolve further for involved software compon=
ents?

Regards,
Markus
