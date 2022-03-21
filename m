Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1434C433EF
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 17:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=/LVzGvrz7TNfuMklPwnRq+TdBqHxnZrZH6YVWbi7LTI=;
  b=HNvJfUiSkHNAnOoyavclJnMweVQ7x3p8jrw0Cg+tKSXMm8mzFiUgXWZ5
   T/TQnRCj8RYRP3ajsoz47bWcgCVe1hQ0h5fV0qgTWFf+B/80xWBNzOcVa
   EtP1aZ57TCbgjVJ1zt2gOj+Ef3ZurhQ6hFINL1hH30G8vWmGUz3LU4Tk0
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27300685"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 18:46:52 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F13F0E0210; Mon, 21 Mar 2022 18:46:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 850CCE0069
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 18:46:49 +0100 (CET)
IronPort-SDR: cFfmlX4qBYxicKKKOiIqiMx7VT7xrSc7B22hElzoQFk50U36Dyw17D0gcm0o0/WVLGv191uRZX
 3bPtSJJS2ZGWaGQ1vnHF4jPUKFfkmk3JlahwX27740SfXZu0koWWe+pqeEbQxlr+A83vQeECC/
 lHTvT57zuSmq19nGboFGX1A+yGraeapfRw0YAxYjXV16yaSKgh65zPQ6Ivhg7+h7u/BUC9/sL9
 IaNmPXp4T6grqJpBw5ayBhtRbc3pH47VcRN5JdLSBjlNP54elcgRB4dqkLJhU2+SH+we6KMysp
 +URSu4s2uqCu6YiA3Z/bMJzU
X-IPAS-Result: =?us-ascii?q?A0DGFQCNuThi/0Xcza1agQmBXIImB4FNAQEBKQQLlAuCK?=
 =?us-ascii?q?IQfmEWBewsBAwENEi8EAQGCEoJ1AoQ8Ah0GBjcDDQECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQEAVYyLAFjAWcBgU4BgXkGBD2CNSkBg2MBAQEBAgE6P?=
 =?us-ascii?q?wULCxguVwaDF4J2IaxbeIEzgQGJe4E9jkgnHECBTYE8gwM+ikQElx6nOpxog?=
 =?us-ascii?q?S6DU59eGi6WSZF1lluhUoUwgT9MAw+BWR8UGggmCoMlTQECAQIBDAECAgECA?=
 =?us-ascii?q?QIBAgEIAQECAZ0MIQEBAWkCBgsBAQMJkXIBAQ?=
IronPort-PHdr: A9a23:zCnbFR/fiKX4k/9uWTy3ngc9DxPPW53KNwIYoqAql6hJOvz6uci4Z
 gqGua4m1QeUFazgqNt8w9LMtK7hXWFSqb2gi1slNKJ2ahkelM8NlBYhCsPWQWfyLfrtcjBoV
 J8aDAwt8H60K1VaF9jjbFPOvHKy8SQSGhLiPgZpO+j5AIHfg9qp2+yo5pHebAtFiDWgbb9uL
 Bi9sBncuNQRjYZ+MKg61wHHomFPe+RYxGNoIUyckhPh7cqu/5Bt7jpdtes5+8FPTav1caI4T
 adFDDs9KGA6+NfrtRjYQgSR4HYXT3gbnQBJAwjB6xH6Q4vxvy7nvedzxCWWIcv7Rq0vVD+88
 6lkVgPniCYfNz447m7XjNBwjLlGqx6lvhBz3pLYbJ2QOPd4Y6jTf84VRXBZU8hfVyJPHJ6yY
 IkMAeoPMulXs5Lwp0cSoRakGQWgGP/jxiFOi3Tr3aM6yeMhEQTe0QIvBdIOsWjbp8j1O6cST
 ++60q3IwivZb/hL3jry9I/IfQw9rvGNRr9wdcvRyVIzFwPelFmft4LkPzOL2esTt2iU8fBgW
 fipi2E5twF8uz6izdojhYfVnIwa0EzE9Tlnz4YvI921UE92bcCgHZZfty+UOJd6T8EiTWxsp
 io3yL4LtJylcSUFxpoqyR7RZvObfoSW/x7vSuScLDl3iX9qd7+xiQu+/FSmx+bhVce0yE5Ho
 jdHn9TCrHwByQDf58idRvdj4EutxSyD2gHX5+xCPEs6j7DUK4Q7zb41jpcTsVrMHivxmEjui
 a+XeV8o9fam6uTnfLrpuJucOJFuig3kNKQhhNC/Dfw5MggIQWeb5fyx2KDh8ED3WrlGkOE6n
 6nDvJzEO8gXurS1Dg5R34o77hawFTam0NAWnXkdK1JFfQqKgJTuO17SPP/4DOyyg1CtkDdw2
 /DGJaftDYvDL3jDjrjuY7J95FBGyAYpy9BQ+Y5UBqkHIP3oQkDxrsDXDgclMwyoxObqEMhx2
 psEWW2TGq+ZLL/SsViQ6+0zJOmDeJMauDfmJvg+5//uiGc5lkUHcamo25sXcnG4Ee58L0WXe
 3q/yusGREIDpAkjV6THjFOYUDhcLyKXVrg/+yp9JYaoF4bFSaiyjbbH0CrtTbNMYWUTJ0qNG
 j/Xd4iJX/oWIHaZJcRqkxQAVKO9UMksyhGjuQv30fxhI/aCqX5Qjo7qyNUgv76brho17zEhS
 p3FiwllLklxl2IMHXot2bxn5FZ6wRGF2LR5hPpREZpS4elIW0E0L82U1PR0Xvb1XA+JZdKVU
 BC+WNzzCjY6RdMZx94Vf107Fsqigx3H0jDsBbIJxPSQHJJh1KXa0jDqItpljXPP1a0vlV4jF
 8BIPmanrqp+7BTIQYPWk0iUk6uwM6IRwH2F73+NmEyJukwQSwtsSePFUHQYM1PRtsj871jeQ
 qWGDKRhPxRBxMOGJ7EMbND15blfbNHkPtmWI2e4mmPqQA2N2qvJdo3hPWMUwCTaDkEA1QEV5
 3ePcwYkVG+npCrFATpiGEiKAQuk+PRiqH69Uk4/zh2bJ0xn2b2v/xcJhPuaA/oN17MAsS0lp
 n16BlG4l97RDtOBoUJmcsA+KZs251xM1ErdthdhJdqtMKBvi1oTaUJxsl+vnxR7B4NckNQ7+
 WswxVkXS+rQ21dAejWEmJHob+SIcS+opE3pMfSOnA+Pg7P0su8V5f81qkvuplSsH0smqTB81
 sVNlmGb7dPMBRYTVpT4VgA28QJ7rvfUeHpYhcuc2HtyPK2zqjKH1cguAb5vwRGrdNZ3NKKfC
 BS0HtIaCsWqJfZsnVW1JEFhXqga5OsvMsWqeuHTkqWsN+1htDanlnhcpo1i0k+B8ydmDOjFw
 9xWppPQlhvCXDD6glC7t8nxko0RfjAeEF20zi38DZJQbKl/FWoSIUGpJcD/htB3hpq3HmVd6
 EbmHVQNnsmgZRuVaVX5mwxWz0Ue53K9y2O+yHRvnjclo7D6vmSGyvn+dBcBJm9ARXVzxVbqL
 4+uitkGXU+uJwE3nRqh7Ez+yuBVvqN6Z2XURE5JeWDxIQQAGuO7sbGJYuZL6Yg0qmNaT+Sxb
 FSXUPj7rgdbmyLvEm1CxSwqIjSju5H3hRt/2wf/ZD54qHvUf901xA+KvYOHA6QJg3xcHnE+1
 2iEYzr0d8Ok9tiViZrZ5+W3Vmb7E4ZWbTGu14SL8i2y+WxtBxS72fG1gNzuVwYggkqZn5FnU
 zvFqBHkb8zlzaO/ZKhseUJjBXf46tFmAcdzjYs9iZUdwz4ci4nfrh9l2S/jdM5W367zdi9HT
 jkAyN/95An+xFYlI22Jyo/9W2/bxMZ9LYrfACteymc26MZED72R5bpPkH5uo1a2mgnWZOB0g
 jYXzfZGBGcypeYPtUJtyyycBupXBkxEJWn2kB/O6dmiraJRbWLpcL6q1UM4k8rzRLeF6hpRX
 nr0YPJAVWd589l/PVTQ0Xby9pCsed/easgWvwGVlBGIhvZcKZY4nP4HzSR9Pme1sXogwu89x
 RtguPPy9JCAMHlo9bmlDwRwMy2zatwT9zzpgLwYmMuKnsiuEphnBjQXTc7oQPavQ1dw/bzsM
 weDFiF5q2/OQOWEW1XHtQE89SqJTcH4UhPfbGMUxthjWhSHcUlWgQROGS4/goZ8DAehgsrob
 EZ+4DkVoF/+sBpFjOxyZHydGi/SohmlbjAsRd2RNh1Tu0tJ4EzeMOSa7/lvBGdV4Z2soQiAM
 CqdahgCXgRrEgSUQkvuOLWj/4yK6++DGu+3NOfDe52LuapTSPeFyJaiyM1g8irGZaDtdjFyS
 vY83ERER3VwHc/Uzi4ORyIgnCXId8eHpR2490WfS+i78e/3Q0Ti+ouCBr9fK5Np9gzk2c9r1
 saVlGB0NjZV25cB3znOxaRNhDb6ZAlqdiKxCvINqi7AQabdgOlRAgJJM0tO
IronPort-Data: A9a23:RdL/Ia2EW1hTBigy0PbD5eF3kn2cJEfYwER7XKvMYLTBsI5bp2RTx
 zAeXmqCPvuIZWf9LdgjO4vkoB9Q6sTWy99lGVZt3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jX4
 IuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt+4yx
 OtcsM2CdR8GDvCSyPs7CzxYLj4raMWq+JefSZS+mcmDiUDZc3bhx/h0Skc7IeX0+M4uXjoIr
 6RFbmpXNlbd1opaw5rjIgVors8kJ8LqFIceoW17izzGDfsrRZ3ZBaPH+be02R9q2ZsWRaiOP
 KL1bxJ1a0iePBpKFG1QFbM7gMj4wSnuMBlx/Qf9Sa0fuDSNl10ugNABKuH9cduBTsR9hVedv
 muA/mLjAxhcOsb39Nae2ne8wOLQnS72XI8IUru16paGnWF/2EQtSxEoRF7qk8WhpX7jBYJAD
 RQx+hcx+P1aGFOQcvHxWBixoXihtxEaWsZNH+BS1Dxh2pY48C7CWTdZFm8phMgO8Z5pFWZzh
 zdlivuwXWQ32IB5X05x4Vt9kN9fES0Fa2IdZSIJSQYfpd/uvOnfby4jrP4/ScZZbfWvRVkcJ
 gxmSgBk2t3/auZSiM2GEajv2W7Em3QwZlddC8W+djvNAvlFTICkfZe0zlPQ8OxNKo2UJnHY4
 iRby5DPsrhUV8jR/MBofAnrNOv5jxpiGGaB6WOD4rF7qmrFF4CLIui8Hw2S1G8ybphfKGC5C
 KMikQ5O5JJeOHawbKl8JtroY/nGPoC7fekJosv8N4IUCqWdgifYpHk2DaNRtkiz+HURfVYXY
 s7KL5zzUS5EVcyKDlOeHo8g7FPi/QhmrUu7eHwx503PPWO2aCHHRLEbHkGJa+xlvqqIrB+Mo
 4RbNtCW0FNST+3zby3a68gVIExTdSo3ApX/qsp2cO+fI1M8RDp7U6KIneosK95/gqBYtubU5
 XXjCEVW/1rImiGVIwu9bH0+OqjkWoxyrC9lMHV0b0qowXUqfa2m8LwbK8ksZbAi+eE6lax0Q
 vAJdt+uGPNKTjibqT0RYYOk/N5mdQ+3nkSDICqobTwyZdhmShCQoo3oeQ7m9S8vCCurtJJk/
 +b6jl6CHcMOHl0wAtzXZfSjy0KKkUIcwO8iDVHVJtRzeVn39NY4ISLGjsgof5MGJyLFy2bIz
 A2RGxoZ+LfA+tdn7NnTiKmYhI61CO8iTFFCFmzW4LvqZynX+m2vnd1JXOqSJG2PUXOy9bqia
 OhRwuu6NvAbxQ4Yv415Grdt7KQ/+9q2/eMBlFw5RSmSYgT5EK5kL1mHwdJL6P9HyIhZjhTqC
 EiBzd9XZOeSM8T/HV9Megd8Nraf1esZkyX55OguJBmo/zd++beKDRdIMx+XhHAPJbd5Ktp4k
 +Ix/sMJ6wGyjhcwdNCLknkMpWiLK3UBVYQht40bWdW30VBzlwgeOJGMWDXr5JyvaslXNhd4K
 DGjhJ3d2+ZWyH3EfidhDnPKx+dc2MoD4UgY0F8YKl2VsdPZnftrjgZJ+DE6Qwk9Is+rCA6v1
 ryH9nGZJJliOx9tlI5OQGChFgVMHluf91CZJ57lUoHGZxHAa4APBDRV1SWxEIQx92NHYiMd8
 a6YxWvhXCyseszttsf3tYiJtNS7JeGcNWT+dASPG8WeA4J8bCXlj6KqaHBOrRb7aS/0aIsru
 sEylNtNhWbH2eL8bkH150R2FVjddfxcGFF/fA==
IronPort-HdrOrdr: A9a23:aWlpiKBM8bM/6HjlHemo55DYdb4zR+YMi2TDtnoBMCC8EKSj+P
 xG88506faZslcssTQb6LW90cq7MBXhHPxOkO0s1N6ZNWGM1QeVxcNZnOzfKlbbak/DH4BmtZ
 uIrJIVNPT7BzFB/KXH3DU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27300683"
X-MGA-submission: =?us-ascii?q?MDGA5purgrAv+WpmnGHhjakgIsH2QwGu54RsQM?=
 =?us-ascii?q?gsUE9zZGECw4L5bvaamIbIJSK1jS/nVFLE9fVi+Gj1w8L0KVtdK8EFAO?=
 =?us-ascii?q?86vQU3gxBBknsn1pZsrWhkXIegctNmg52qAnPnKU4ZPTFabriC9o1N7u?=
 =?us-ascii?q?Wn/FYOGVwqHmh9x/8HAAebwA=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 18:46:48 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 3827548;
	Mon, 21 Mar 2022 10:46:47 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yXHMyK1VWiRU; Mon, 21 Mar 2022 10:46:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 660A741;
	Mon, 21 Mar 2022 10:46:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 660A741
Date: Mon, 21 Mar 2022 10:46:45 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <trinity-aa278557-9b21-4086-848b-218a903ce0ee-1647853331428@3c-app-webde-bap05>
Message-ID: <6355cbc2-9bb1-3c72-43d3-a02e48df52e@ewheeler.net>
References: <a28111b-90ab-1d57-58de-113a50f61f41@ewheeler.net> <trinity-aa278557-9b21-4086-848b-218a903ce0ee-1647853331428@3c-app-webde-bap05>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Is there a stringify operator?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 275
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/6355cbc2-9bb1-3c72-43d3-a02e48df52e%40ewheeler.net>

On Mon, 21 Mar 2022, Markus Elfring wrote:
> > I keep running into situations where it would be nice to stringify an
> > arbitrary metavariable.
> >
> > For example:
> >
> > 	@ r1 @
> > 	type T;
> > 	identifier I;
> > 	@@
> > 	T I;
> >
> > 	@ r2 @
> > 	type r1.T;
> > 	identifier r1.I;
> > 	@@
> > 	++printf(#I " has a datatype of " #T "\n");
> 
> Do you need any extra debug information?
> 
> Are you looking for further advices so that more source code transformation
> alternatives will become interesting?

What do you mean?

> > Not sure of others would find a '#' operator or some other stringify
> > functionality in Coccinelle useful...
> 
> Would you like to try additional data processing possibilities out together with
> the scripting languages which are supported by the Coccinelle software?

Possibly, but I really like the Coccinelle syntax.  If I knew OCaml then I 
might even try to submit patches for things like this that look simple 
enough.

> Regards,
> Markus
> 
