Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEB9C433EF
	for <cocci@archiver.kernel.org>; Wed, 16 Mar 2022 20:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=eQ/GHvB5jeQF0mmb9eFbtlftrnNBy4eVDZAwGIAjx2Y=;
  b=k9rKRlKngPALiT4VduZGfSpEQUkvkfkxfuGGk9K42no3F3nJj3zJjplH
   rp3nds6GFKLV8A2xnfAYp3lyfkNEI3zQ409Y0WrhNKycpi3VqsIMY6CJ7
   j+kjqatbLVFl7XRihD6ETviyUDsAZxItW2aTzDP/+w1i4dg/76bIEqOAu
   A=;
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
X-IronPort-AV: E=Sophos;i="5.90,187,1643670000"; 
   d="scan'208";a="26537717"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Mar 2022 21:48:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C158DE0044; Wed, 16 Mar 2022 21:48:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 35099E0030
	for <cocci@sympa.inria.fr>; Wed, 16 Mar 2022 21:48:44 +0100 (CET)
IronPort-SDR: 5Ow3E6/X7fqL4CmPii6+Sr3DMCszcL3S/nkwpWCiGqLSniXP/520Va32VPgOU1Zk7BBq19nhRr
 NUdDxbyIC/XVpVFAU0mGTDVeoIMLwYJkMZ2insknP31s4rAx8zPSstQVY5FQ+NFwb7Hr44Zvo4
 IW2aqDUQdjIXkVs7pwVB++i8P/oK3z4G6sZXh8GjAcsLFHnkiYOUW0CLLMLXn39upIjH2STHhw
 FQu+PdDmgGwkCM5WZDRxSLj3Xk7NPdHMULV2Z6YblYQeAVGlIQSOUZQd1wFYWScS54d0c3m615
 43DveyC8F0Y3BRy82XVPd+sD
X-IPAS-Result: =?us-ascii?q?A0A2BwBlTDJi/0Xcza1agQmBWoIoB4FNAQEBKQQLlAuBd?=
 =?us-ascii?q?4NXmzgLAQMBDUEEAQGJMwIdBgYzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIDBAGBCCwBYwFnAYFOAYF5BgQ9gjUihCyFFIMXr12BM4EBiXuBPIYUV?=
 =?us-ascii?q?ogGHECBTYE8glOGAIUyBJwZog6eE4NTBZ9VBhQug2EBkmORdJZZoUiFOIE/O?=
 =?us-ascii?q?CaBWR8UGggmCoMlTQECAQIBDAECAgECAQIBAgEIAQECAY10ATMWjk4hAQEBa?=
 =?us-ascii?q?QIGCwEBAwmOWQEB?=
IronPort-PHdr: A9a23:BU2Jth1geLcbupCCsmDO8w8yDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BaFo6w21hSQBtiTwskHotKei7rnV20E7MTJm1E5W7sIaSU4j94LlRcrGs+PBB6zBvfraysnA
 JYKDwc9rDm0PkdPBcnxeUDZrGGs4j4OABX/Mhd+KvjoFoLIgMm7yf6+94fObwhGmjaxbq5+I
 Ru2oA7MqsQYnIxuJ7orxBDUuHVIYeNWxW1pJVKXgRnx49q78YBg/SpNpf8v7tZMXqrmcas2S
 7xYFykmPHsu5ML3rxnDTBCA6WUaX24LjxdHGQnF7BX9Xpfsriv3s/d21SeGMcHqS70/RDKv5
 LppRhD1kicKLzA3/mHJhMJtj6xUrw6uqgdjw4LIeoyZKOZycr/Dcd4cWGFPXtxRVytEAo6kY
 IUPFesBMvpFpIb9p1sBswWxBQ2yC+P11zRFgWP53aom3Os9EAHLxwggH9MVsHTIt9X5LrkdU
 O61zKbW0zrDa+1Z2S3n5IjObB8hveiBULRtesXe1UchDRnKjkmMqYP7JTOV0PwAvmuf4uZ8W
 u+ilWAqpgV/rzSy28ogl4rEiIwVx1zY6Ch0z5s5KMOlREN1YdOpDphduiOEOoZqTM4vR39kt
 Tgkx7AApJW1fzAKxYw6yxPdZfGLaZaE7g7jWeqLPzt0mm5pdKi+ihu290Wr1/fyWdOu0FlQq
 ypIitnMuW4J1xzU8sWHT/R88l2/1jeB1wDc9P9LIUQqmqrBMZIhxKA/loYLvUTCGC/5hln2g
 beLekgm9OWk8frrbqnmq5OGKYN4lB3yPr4vl8G7Geg4NxIBX2mf+eSyzr3j+kj5Ta1Wgf0xj
 qbWrJHaKN8fpq64GA9Vzp0j5wyhADao0NQXg2cILFZbdxKdlYTpPU/BIOzgAfe5mFujiC1ry
 OzePr39HpXNKWDOnKr5cbZn90Fc0BYzzcxY559MFr4BJ+78VVPwtNHDFR84Mwm0w/79B9ln1
 4MeX3iPAq6DP6/Iv1+I/LFnH+7Zb4geszfVKv4/5veog2Vqt0UaePyEx5ocIE+4E/liLl/RN
 XHridwAOWMLpRYlCuH1iFCPVTNJIXC/Q/RvtXkAFIu6ANKbFciWi7ub0XLjdnU3TmVPC1TWV
 Gzta53BQfAHLiSbPs5mlDUAE7mnUY4okx+050fh07QyCO3S92UDsI77ksBv7rjYkho59BRwD
 t+ByCeAUGF5k2cFXXkw0bws6VdlxAKl1q51y+ddCcQV4vpIVgkgMpuJxOtxANHaXgPaYszPR
 UmmT9iiDCt3SN8tkJcVe0goPdKkg1jY2jayRb8Yk7veHJsv7qfVxGT8Pe542zDLy6ksgl0rW
 I1JOHHOardX0Q/VCsaJlkyYk/zvbqEAxGvX82zFy2OSvUZeWQo2UKPfXHlZaFGE5dL+rljPS
 bOjE9FFekNI1NKCJ61Wa9bokUQORfHtP87ban6wnGH4DAiBx7eFZo7nM2sH2yCVBE8BmgEVt
 XGIUGp2TiymqGnfJDhvDk70JU7z8eRzrH6hCEk500DCbkFs0aa05g9AneaVGJZxlvoPvCYsr
 SkxHU7oho2NTYDY+kw7Jv0aP4JuhTUPnXjUvAF8IJG6eqVrh1pENh9yo1urzRJ8TINJjcktq
 nouigt0M6ORll1bJFb6ldj9PKPaLm7q8VWhcanTjxvV192d+48L6e8ksBPuowGkG04v6TNh3
 sUfgB7+rt3aSREfV578SBN9/B9xrLDyZigm+5iS2GJsPKSwvyWE3d81TrhAqF7ob5JUN6WKE
 xX3GssRCp21KeAkrFOuawoNIOFY8KNc09qOUfyA1ebrOe9hmGjjlmFb+MVn1UnK8SNgS+nO1
 pJDwveC3wLBWS2uxFGm+tv6n4xJf1RwViK21DTkCYhNZ6ZzYZdDCGGgJNeyz8l/gJilUmBR9
 VqqDVcLkMGzfh/aY1v41AxWnUMZxB7v0SC/xDd1uzUotbaEmiHRw+nvcBcdfGhGWCgqjFvhJ
 5S1k8FPWUGpawYzkx72gCSyj6Nfpal5MyzSWRIRIHOwdTk/FPHq7vzcMp0qittgqyhcXeWib
 ErPT7f8p0FfyCb/By5Ewzt9cTi2u5L/lhg8iWSHLX81omCKHKM4jRrZ+tHYQuZcmzQcQywtw
 zLQDVO9F92o5smP0Zrcsu2zU2+7EJtebWO4qOHI/Dv+/mBsDRClyrq4ndbsECA+0DTnzJ9nS
 iXFoRLxeM/t2rjwYocFNgF4QVT77cR9AIR3lIA90YoR1XYtjZKQ5XMbkG33PL23wIrYa3wAD
 X4Oyt/Ruk3+3VF7a2iOzMT/X2mcxc1oY5+7ZHkX02Qz9ZICDqDc97FCkSZvxzjw5QvMffhwm
 Cscwvoy+TYbhe8Oog8k0iSaBPgbA0BZOSXmkxnA4cq5qe1bY2OmcL7400Qb/5jpFLaZvgRVQ
 2r0YL8nDWl98cVyPVbByjv1552lMNjcYNQPtwGFxhfNi+8GTfB53vEOhCdhJSf8pSh8lLV91
 0Qzm8vg5M7ZejYInurxGBNTOzzratlG/zjsifwbhcOKx8W1GZ4nHDwXXZzuRPbuETQItP2hO
 RzddV904nqdB7fbGheSrUl8qHeaWZusPHqWDH0Y1sl5AhSCJEFShA0OGjM3gtRqc2LijNyka
 0p/6j0LsxTgrQBQz+tzKxTlemLP4gq3ajo5TJWFahxb8ksRgiWdedzb5eV1ESZC+5SnpwHYM
 W2XaTNDCmQRU1CFDVTuVlFLzd3B6PSDQOehL/bDZbiU7+pTS6XQrXpA+o9n5CqXcMiQPnRvC
 /AhnExOQSIhcyw4szAfDSEIly/Aa8OB4hGx5n8vxv0=
IronPort-Data: A9a23:0u7Q3KgOtluPCbW6+5yH0ZP9X161RRYKZh0ujC45NGQN5FlHY01je
 htvCjuAafbfYzHzLY9xOdmz/RhU6JGAm4RnHQY/+3w0RC5jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq+JSBYAXNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 NplicKicl0QM/H3mss6egRiMgwkLOpn5+qSSZS/mZT7I0zudmuqzupuAUwyMJde/OtraY1M3
 aVHc3ZXNk3F3bjuhuzqIgVvrpxLwM3DN4QUsXBIyTDCEe1gTI/DTqjO6MUe2jos7ixLNayAO
 pFGNmMxBPjGS0ZGFU1QT684puytmEPgQmIEjXbWrqVitgA/yyQqjOa2YYWFEjCQfu1emU2Tp
 0rd7mHhC1cbMsaewHyL6BqRavTnmDO9VZ0SGbC8++QshlCProAONPEIfWfls8Ljs0PiYNBwD
 GUJwAsD97l11VP+G7ERQCaEiHKDuxcdXf9ZHOs79ByBx8Lo3uqJOoQXZmUeN4F+5afaURRvh
 wDZxYq4bdB6mOTNESr1y1uCkd+l1cEowYIqYD9CQBQF7tTnrZt1iB/TJjqCLEJXpoaqcd0T6
 2rWxMTbu1n0pZdWv5hXBXid31qRSmHhF2bYJmz/BwpJFD9Rao+/fJCP4lPG9/tGJ4vxZgDf4
 CdeypDBt7pRUcjleMmxrAMlR+vBCxGta2K0vLKSN8N8qVxBBVb9FWyv3N2ODBw1bJ1VJm+Bj
 L77tBxR6ZJXMWGra6QyO9vZNijZ5fOIKDkkP9iKBudzjm9ZL1bWonsxORbOgwgAUiEEyMkCB
 HtSSu70ZV5yNEit5GPeqz413eB5yyYg63nUQJynnR2r3aDHNCyRSKwZKx2DceA04aeJukPT/
 soGb5mGzBBWUevfZCjL8NdJcQtQdSViWcn7+55Na+qOAgt6A2V/WfXf9rMWZNA3lapikOqVr
 Gq2XVVVyQehiCSfexmKcH1qdJjmQY178SAgJSUpMFvxgyojbI+j4b0xbZwyebV7puVvweQtH
 6sBet6cGbJCVTTK9jAQd9/7oZA7LEanggeHPiyEZjkjfsc6G1eTooK9IlLirXBcADC2uM0yp
 6yb+jnaGZdTFR5/CMv2ae60yw3jt3YqmNVtAxnCLO5VdRi+64NtMSHw06E6epleNRXZyzKG/
 A+KGhNE9/LVqoo4/dSV16CJq4ClT7l3EkZARjSJ6KbwODba82enzJUGVuuUJGiPWGTx8aSkR
 ONU0/ClaqFcxg4X6tYlHuY517866vvuu6RekFZuEkLLWEv3WLluFX+LgJtUvapXy74E5wbvA
 hCT+sNXMKmiMd/+FAJDPxIsa+mOiaMOlj/J4ahnKUn2/nYqrr+XF0hNPxSBjCFHar14LNp9k
 +smvccX7S25iwYra4za1XoMqj3Qd3FQAb86spw6AZPwjlR5wF91YavDVn387qaJZogeKUItO
 DKV2fTP3uwO2krYfnMvPnHRxu4B148WsRVHwVJqy45lQTYZaivbHSG98AjbiixQ3lNKzOJ+N
 2xmLQtzKLnmE/KEQiRcdzjEJu2DLETxFo/NJ58hkGzCU1LuW3PNIWA5NPzL+k0Fm46Zkv634
 5nAoFsIkl/WkAXZ2iopRVUjpuPjQNF1+xeEns27dyhA81/WfhK96pKTiaE0R9cLzC//aIArZ
 QWnwQqoVZDGCA==
IronPort-HdrOrdr: A9a23:tVBs9aC3w/m8TSPlHem855DYdb4zR+YMi2TDtnoBLSC8EKSj+P
 xG88506faZslcssRIb6LW90cu7MBHhHPdOiOF7UNuftWLdyQiVxe9ZjbcKHAeLJxHD
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,187,1643670000"; 
   d="scan'208";a="26537716"
X-MGA-submission: =?us-ascii?q?MDGaGH4g8K+N8J4InI7/QtOjhxoFSpWYa8Lt2L?=
 =?us-ascii?q?9G0+/9ehEFlVW4AYcXz8ogU/Lgn/1zWgWKLPeiaacIK9zt7u0wzV7wsI?=
 =?us-ascii?q?QCEI7yDXuANnuK09mJkYwYXhKv/xWnkIwKAqbr7fBiPcScP8wwfgGG1q?=
 =?us-ascii?q?GA75jLlNByctSwiTu0+kG/LQ=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 21:48:43 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 4DBA441
	for <cocci@inria.fr>; Wed, 16 Mar 2022 13:48:41 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BHdYTzXOvR1W for <cocci@inria.fr>;
	Wed, 16 Mar 2022 13:48:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 902B740
	for <cocci@inria.fr>; Wed, 16 Mar 2022 13:48:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 902B740
Date: Wed, 16 Mar 2022 13:48:29 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <2ae57eac-cef9-c3e9-4ec5-5330884e7bdc@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] Can coccinelle match when an identifier exists anywhere in
 an expression?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 227
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/2ae57eac-cef9-c3e9-4ec5-5330884e7bdc%40ewheeler.net>

Hello all,

If I have a function like this:

	int length; // global
	void f(int i)
	{
		return 10 * i * length + 1;
	}

Then how can I write an SmPL to match when  `length` exists anywhere 
within an expression?  The expression format varies.

This doesn't seem to match:

@ r @
expression E =~ "length"
@@                                      
*E                                      

--
Eric Wheeler
