Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E61C433F5
	for <cocci@archiver.kernel.org>; Sun, 13 Mar 2022 09:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=LsbKO5EAEkgAPg8IqwYhIJGYwyX+4DB6QcmV5tPxBdI=;
  b=hNkdzu9RkaxgFDzq8XINoAOU4xlnXDdVlZyHUIzeV2YQCyiZjj6X6p5X
   70DDUQMSg2jyKA7eqcK94FAvgjaIwwCL12FPfoBZ4JgvsD8J8JO2hZEeQ
   AWxN8fLZCFlM9YoUwPQarTNjx+kG637AwZlrmBGsdVSH/ICQ5Ru0bNHAR
   E=;
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
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25846350"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Mar 2022 10:46:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 96E84E004A; Sun, 13 Mar 2022 10:46:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 21C0CE0045
	for <cocci@sympa.inria.fr>; Sun, 13 Mar 2022 10:46:07 +0100 (CET)
IronPort-SDR: p8DIdV2iplz51p2n8meay07O/ji8cnumI9uYBQAVfGSOlz8JMe4TS+frHb8+jPA3TdX3tyQ100
 5nQJvqyUy4x3HSB1hdZId7UN1GrGVND2AuPOZc44mb7RWhN8J1j/o0ffbc0RbWaQgLL9pVpApE
 pqd8BuCB4n88h9jJW3aqC7NR0be9hwYKcTAKxVRgg+pLZfOXCzG1o3SfluT3/FXGb3Y6Y+O3bA
 ulQ8QoOKVvLkLJlcjN3RdaOX3qEizncuDxd9Kr6zSOww6FYnY0R9wG0DcjjRlA1TT1/En+FbgC
 Pa193zMUK63u/uDYwEafP5zJ
X-IPAS-Result: =?us-ascii?q?A0DoAQADvC1ih07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VqCKH5XKwQLRIRUjnOBdzGeWwsBAwENNQkBAgQBAYUHAoQkAh0HAQQ0EwECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgMEARMBAQEMDQkFCAoHDgULBTYGX?=
 =?us-ascii?q?gZkBIFLBIF0CzQNgjUig2wBAgIBIx0BAREnBAsJAg4MAiYCAlcGAQwIAQGDA?=
 =?us-ascii?q?AGCZAEDDSULkkecDIExgQGCCAEBBoRIHywiUoFbAwaBECyKN4QRJxCBVUSBP?=
 =?us-ascii?q?IEVgT4wPoJjBAGBXYMagmWYJBMsCYI0Or9wNAeCEoE6gUALiT+UTAYULpY6D?=
 =?us-ascii?q?gaRaZZXIIxzmWiBeIF+MxokgzhOAQIBAg0BAgIDAQIBAgkBAQKOHQwNCYNQM?=
 =?us-ascii?q?4osQDQ4AgYBCgEBAwmFRwEBjRwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:RKOknaJYx4pHTajiFE+RjpMlxSXFcZb7ZxGr2PjKsXjdYENShmQGz
 2IfUDzXP67YMzemKdwkbt7g8UwD6MfWzoAyGlAd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefRLlbFILas1hpZHGeIcw98z0M78wIFqtQw24LhWFrW4
 YqaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhn/t78
 tMdmo2JYCRuJ4reoM08AgNSKnQrVUFG0OevzXmXtMuO0wvZfnGqz/gG4EMeZ9RHvLktRzgfr
 7pHeFjhbTjb7w6y6JeyUOpxnYIOKMfxPYUQkm5tx3fVAJ7KRLiZHvWWu4QEgF/cgOhEN+TlX
 tEAcABuQzfCXA11GnwwNKMhybLAan7XKmAE9gvM+8Lb+VP7xwt627nFK8vQYtXMRMNPn0/eq
 HiuwojiKhQdKcDZ1jePtH6h7gPSoc/lcII5Hoe+ptF7uXSwgXU0GiU/dAqhq8Ds3yZSROljA
 0AT/yMvq407+0qqUsTxUnWEnZKUgvIPc4cJSbxrs2lh3oKFv1fAXgDoWxYbMIROiSMgedA9/
 nOk9+4F6BRqt6CJD22Q/PGYoFte2BT5z0dSO0foriNfu7EPRb3faDqRF76P94br1LXI9cnYm
 WzikcTHr+x7YTQ3/6u650vbpDmnu4LESAU4ji2OAD76t1oiPtP+NtD4gbQ+0RqmBNnJJrVml
 CdV8/VyEMhVUvlhaQTQHLRTR+vBCwitamGM3AEH82YdG8SFoiP/I9kJvlmS1W8wfJ9MeDn1b
 VXVtB8Z7ZA7AZdZRf8fXm5FMOxzlfKIPY29CJj8N4MSCrAsKlPv1HwwNCa4gjG1+GBxwPpXE
 crKIa6EUyxHYYw5l2Deb7lGjtcWKtUWnj67qWbTlEj8jtJzpRe9Fd84Dbd5Rrtgvf3e/1mNr
 Yo32gnj40w3bdASqxL/qeY7RW3m51BgbXwvg8AIJOOFPCR8H2QtV63Yzb87Jd56kq4TmuqRp
 iOxXUpRyVzeg3zbKFzWOy45N+61Bc5y/SAhICghHVe0wHx9M4yh26coccdld7cQ8uE+n+V/S
 OMIepnbD/kWEmbH9j0RYIPTtotncBj31wuCMzD7MicyddhsSlWRqNPjewLu8ggIDza27Jdv/
 ef/i1mDGZdaHlZsFsfbbv6r3midh3lFlbIgRVbML/lSZF7ortpgJRvxuflrccsCHhPOm2mB3
 AGMDBZE/uTArtNn8NTNgqzY/Y6lH/EnRxhfGHTHq6m7P2/W8zP7k4NHVe+JexHbVX/1ofnzO
 78KkqukaPBXzkxXt4dcEqpwyfxs7dXYp4hcklZuEkLNYgn5EbhnOHSHgZJCu/Ef3LNfogfqC
 EuD9sMDYOeMP975VkEcLkwpY73bh/0TnzDT69UzIVn7vXMmouDYDB8KZxTc2jZAKLZVMZ8+x
 blzssAh6zu51kggPOGAg30G7G+LNHEBD/4qu5xy7FUHUeb3JoyuoKAwCxMaJLmKbMhQdFYnK
 HmYicIuQliaKlXqKxIO+brlhIKxRqjifDhVwVVEK1nhdh/tmKosxBMImdgoZl098/iEut6f/
 kB0OkczKajmE/KEQiRcdzjEJjytzyF1NqA8J5XlWYEZo4SVurTxEVAA
IronPort-HdrOrdr: A9a23:Wj2tSawZJO3V8+3VRxBwKrPwAr1zdoMgy1knxilNoG9uA6+lfq
 eV7Y0mPH7P+VAssRQb8uxoV5PufZqxz+8Q3WBVB8bEYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 JdmsNFaOEYY2IK7/oSrDPYLz46quP3iJxAaN2utEuEdGtRGttdB4wVMGymLnE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,178,1643670000"; 
   d="scan'208";a="25846344"
X-MGA-submission: =?us-ascii?q?MDHACc0WcVw7vK1AQBp43L1ilQvdEhUE0kePZl?=
 =?us-ascii?q?vxRgjLGfxjCmvLuogvevqJVvABgvubNLQPhV1FsYY2ymwvWYdnW0zFm6?=
 =?us-ascii?q?fkjKCSCxutz+CgbMEVxNtjZnJdHwsgWL1O8WwinXqwZqOT/P/+RgzIv9?=
 =?us-ascii?q?VRF8SnO8lA1Pvc9uW+wZ99dw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 10:46:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1647164765;
	bh=k3XYGwg9DV3+F6cd2gjXWo9zGSaWOrJ3lUmDAQOJG8Y=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=ZVqpNXe2mfV8Iz3zDItZcokMhXTsf9T86WFsBFsrq8gPekgMghPG3G1yTYJoN1UZy
	 aoQEbzWImAY6stzFCnAKsAt6t2ahy08wsHv9s6U6RDFYguzSPaEe0glEhwP2/G3xgm
	 xYQSaQYJprNWReZPdfUfN+25h7YGmcrlz9QNdpTk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.179.181]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N30dT-1o7dke1xT3-013BqW; Sun, 13
 Mar 2022 10:46:05 +0100
Message-ID: <caf9ec38-c627-711d-885d-b975cc914fca@web.de>
Date: Sun, 13 Mar 2022 10:45:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Eric Wheeler <cocci@lists.ewheeler.net>, cocci@inria.fr
References: <9112994e-3913-54e-dfc1-b1b7f54fc191@ewheeler.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9112994e-3913-54e-dfc1-b1b7f54fc191@ewheeler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zCQAk+/4Klq8fgm1PqyPwjagQk3swoG+TkKkp1pkHzecMMIlZ8U
 oEcW1uL/DW6kES5dtx2ExoTV767znQOXrRGtk6GfyFG0BLd/byvDOGIXa13sCtqHQisYpXH
 ImJkDYHE5macIa+WQBSN8VaqpmN+h0rcrgrswanNZ1BV+1yn38w5TXwIjyO1gIr844JX7Nq
 2rpyZ0iXr5AIej0cr6PKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3spymn5/ZbI=:oumhrZCLQrPf3l/1v2pwpx
 KgB72JUHM4owpLh8hfosJyPOvIj48sQwXQq3PiFlO6Q4ZJ4LTyfhZ0EZNKKdYYgBZF7doBT85
 EDWQ6qVx1vcil/t7Ifipyk+frekgeVHBCdPbcnhXYI9Byqz7b8/2Nd0mGYgqncHIdwpWlkKHL
 Cgio+3vUYac66OM/6bvSydrYlCaSQhYRn+wnM+NIiEICo9P5bd7TVfRzFqlaRWvraKRfCBA3T
 jLTYqdy6qU4VK6fsLDm8fYm1VWo017sATDkuNonttRd6ORTu31T95B9oY+UAkgeNjTByonSNX
 Cngvu+q28bLDU4AvzhcR2biecXydr6Fg6cz9oGJ46YVklELnZ+h+Biz/CvyaEBJfM/NeeI/o8
 5wlTVEPcRlfXjc7499OTTKwR/xEYWQceeYvS71cbKH6o6C+NpNemLH2Vx4nQTQyicarosBFoO
 OASi1gQQi28aFNeK90V5htOW6waR+Iw0+lCViRT0XCM78w/sf/yoN10lxByANidKc3Ge8esxD
 1bvlYGXOPuVfYGgKUsSuJOqIkuonOSHd0CRyUexWJsaGAla4SLAXX8V/HBWMae1AqcwrMAocP
 3Hz2GD2+zPpFWWOGp/uQnG6dzLDb1lmleSiXdlkW9vQEYU9xLyKWa8HQdG/d/71uzOlv+Yvqr
 6KW5p8DwWhgxMI/ivF7i+Z1fjgOPCsfmmwdYIr++niTNzMJz/YXURO61l8jTQYsaK1n2qDOa7
 UDIM+wepR0HGLSQXXlZv+gHyf8sxVeoZ4XfTv0sBCJaWsNmH7beVA7MeZjw6H8u5gk5p60dyb
 XmgOfe+bH4xGiTtCUSlnU05Iv/Kb4/Qgur/oNd9/h3eciULfY+Py2GrhTrmlgD3vqAtVEzJj+
 q25wWJZsj3lEpakNgXAly7d/oMgTZ47LDkbqaz5Vu/SyRYwp+8DvN+41Fru/91Fn1agymlNto
 konk6mDwxjWvWzS8kLBjm0ZJGfGqwX9SGNtkErxshyzL67nLXp5G5QBvudbfg1WOAdwJXCoov
 zPffzQu3uQY63zwy389NJq90R8DEACdTYVZNZeOrGu28AKze617R+vvGCDdODhOmn/r1+7muR
 5HLPwxDED4q1ok=
Subject: Re: [cocci] Can Coccinelle concatenate or append to existing string
 literals?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 215
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/caf9ec38-c627-711d-885d-b975cc914fca%40web.de>


> to produce this:
>
> 	void f()
> 	{
> 	-	foo("foo");
> 	+	foo("foo_bar");
> 	}
>
> It looks like `fresh identifier` can do something like this,
> but I can't get it to work with strings.


I suggest to increase the distinction which data parts you would like to m=
odify
for such a transformation attempt.



> Is there a way?


Will another test result for a SmPL script like the following trigger any =
further
collateral evolution?

@addition@
@@
=C2=A0void f()
=C2=A0{
=C2=A0foo("foo"
+=C2=A0=C2=A0=C2=A0 "_bar"
=C2=A0=C2=A0=C2=A0 );
=C2=A0}


Markus_Elfring@Sonne:=E2=80=A6Projekte/Coccinelle/Probe> spatch --parse-co=
cci append_to_string_literal1.cocci
=E2=80=A6
plus: parse error:
=C2=A0 File "append_to_string_literal1.cocci", line 6, column 10, charpos =
=3D 48
=C2=A0 around =3D '"',
=C2=A0 whole content =3D +=C2=A0=C2=A0=C2=A0 "_bar"


How will the chances evolve to support string literal concatenations bette=
r here
(by the means of the semantic patch language)?
https://en.cppreference.com/w/c/language/string_literal#Explanation


@initialize:python@
@@
import re

@find_update_candidate@
constant input_string;
position pos;
@@
=C2=A0void f()
=C2=A0{
=C2=A0foo@pos(input_string);
=C2=A0}

@script:python selection@
param << find_update_candidate.input_string;
text;
@@
if param =3D=3D '"foo"':
=C2=A0=C2=A0 coccinelle.text =3D cocci.make_expr('"foo_bar"')
else:
=C2=A0=C2=A0 cocci.include_match(False)

@replacement@
constant find_update_candidate.input_string, selection.text;
position find_update_candidate.pos;
@@
=C2=A0void f()
=C2=A0{
=C2=A0foo@pos(
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 input_string
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 text
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 );
=C2=A0}


Markus_Elfring@Sonne:=E2=80=A6Projekte/Coccinelle/Probe> spatch append_to_=
string_literal2.cocci string_literal_usage1.c
=E2=80=A6
@@ -1,4 +1,4 @@
=C2=A0void f()
=C2=A0{
-foo("foo");
+foo("foo_bar");
=C2=A0}


Regards,
Markus

