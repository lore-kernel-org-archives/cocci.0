Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A880C433EF
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 02:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0YekDk5vSez6q8hj9Dr2laQXF5g4pMFaEx+wVGAGY4M=;
  b=TPZhCo4m964PNXLCx+tTpK2qn7YmqUn3VMRdBF3cu06A3rd5a4jFOVMq
   6O9CWQWxn2Wco0bdqKloQYOlR/flNbipRjoe/hhJHSdamfL8vwQpDXK1V
   C82BMrFcNm64262Jx/ASZVJT1+E2iBqmuJXdTt9dT5/N0GXs63vtTDgPI
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
X-IronPort-AV: E=Sophos;i="5.90,197,1643670000"; 
   d="scan'208";a="27117464"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 03:55:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DA2A8E0210; Mon, 21 Mar 2022 03:55:08 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EA1ECE0069
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 03:55:03 +0100 (CET)
IronPort-SDR: dZWtRfOo4bMH/GwAEmJsIZOOKGrBHBwUWYpWwhh8FzqxHzEnWuD4koG/33K1/ZQF7Kf0lvEXHi
 cxSWc0El7qrR7NzZ33UyEeCX4AyYVf7Za0acP+7rh1vMIdyuoBPm2V9jTQq9lXOC/k79jjKJeo
 MhIkZEgZwIFGMT1DrlfDoQdUtOeb0awOnS4iGG2AgUPeXv5YAUz6vyGYMne7q4ZY9+GAdYiSf0
 LEYvTkNseG7FQ1lzua+TPK2BIY7K5wPrJq+4Y3zkpWiq5IAxy5zsjhtqOZQ9ARIZQ8ANbuiUWi
 gfiqbFaL5f0eCr+7rqiFOW6t
X-IPAS-Result: =?us-ascii?q?A0A9BQBD6Ddi/0Xcza1agQmBWoIoB4FNAQEBKQQLlAuFT?=
 =?us-ascii?q?nmYRIF8CwEDAQ1BBAEBiT0CHQYGMQgOAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECBAQBVjIsAWMBZwGBTgGBeQYEPYI1IoQshRSDF60mgTOBAYl7gTyGF?=
 =?us-ascii?q?BRCiAYcQIFNgTwMgzWFEoUyBJkKlU6Pfp4Wg1OJcpVsBhQug2IBkmaRdZZbo?=
 =?us-ascii?q?UqFOIE/IwE6gVkfFBoIJgqDJU0BAgECAQwBAgIBAgECAQIBCAEBAgGNdAEzF?=
 =?us-ascii?q?o5OIQEBAWkCBgsBAQMJkXIBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:gIMuk6x24HLViry0qH96t+cEwCrEfRIJ4+MujC+fZmUNrF6WrkUBn
 zNOCz+FOfaLa2Wmc4txPo6xoRgHsMDVmNJnHgU9rVhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefQAOOU5NfsYkidfyc9IMsaoU8lyrZRbrJA24DjWVvW4
 4uq+aUzBXf8s9JKGjJMg068gEg31BjCkGtwUosWOJinFHeH/5UkJMp3yZOZdxMUcaEIdgKOf
 Nsv+Znilo/vE7jBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XOdJEAXq7hQllkPhM8
 vJxi4fhdD4xJ6n1iukhXTcJEThXaPguFL/veRBTsOSW3wvLbHvhzvFjFgcwMJFwFuRfWD4Vs
 6ZAdXZXNEjF2bPeLLGTEoGAguwoK8LgPasbu2p81nfUEvYrTJTOWePM6MMwMDIY15geQK6CP
 qL1bxIoUBfnTBJVY2wxN5Qlrcaxu2XfKxdx/Qf9Sa0fuDSNl10ugNABKuH9cduBTsR9hVedv
 muA/mLjAxhcOsb39Nae2ne8wOLQnS72XI8IUru16paGnWF/2EQuMjoqa0DqnMChk0qHSd9jJ
 WJF+DMH+P1aGFOQcvHxWBixoXihtxEaWsZNH+BS1Dxh2pY48C7CWTdZFm8phMgO8Z5pFWZzh
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
IronPort-HdrOrdr: A9a23:ayaXHKP69BMbbcBcTtGjsMiBIKoaSvp037BL7TEUdfQ2Gvb2qy
 nAppomPHPP6Qr5O0tQ/OxoWpPwI080nKQdieJ9UYtKNzOW21dAQrsD0WI8+VfdJxE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,197,1643670000"; 
   d="scan'208";a="9085041"
X-MGA-submission: =?us-ascii?q?MDFMNgDr3MKbrIiBqBYfOG45//Be5VSW7VsRUU?=
 =?us-ascii?q?b7cT242FeqSVk1Vb2Vn17zPf6qG/ONZHzvGAFO1CG+scWn3rUKfce0Zr?=
 =?us-ascii?q?g4Yb7HH7j708zDyMRM3gn/g/6Ak1EDLX1SE7I+imMv+D3s7LW4Hn0QTH?=
 =?us-ascii?q?klUejhc4lSrvV8RedZtycSnw=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 03:55:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id B3ED281
	for <cocci@inria.fr>; Sun, 20 Mar 2022 19:54:59 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rCDHvez7HNrI for <cocci@inria.fr>;
	Sun, 20 Mar 2022 19:54:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id D146E40
	for <cocci@inria.fr>; Sun, 20 Mar 2022 19:54:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net D146E40
Date: Sun, 20 Mar 2022 19:54:57 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: cocci@inria.fr
Message-ID: <bc3ed55e-46e6-7ad7-9297-2eea753f24c5@ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] minus: parse error: around "..."
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 269
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/bc3ed55e-46e6-7ad7-9297-2eea753f24c5%40ewheeler.net>

Hello,

I'm getting a strange error with this ruleset:

	@ add_diff_structures @
	@@
	+void diff_structures();
	void New_Frequency(...)
	{
	    ...
	+   diff_structures();
	}
	...
	void Incident_Field_Loop(...) { ... }
	+void diff_structures() { }

same error here:
	@ add_diff_structures @
	@@
	...
	void Incident_Field_Loop(...) { ... }
	+void diff_structures() { }


I was able to break it into two rules, but can I not use "..." between 
function bodies?

--
Eric Wheeler
