Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B176C74A5B
	for <cocci@archiver.kernel.org>; Wed, 29 Mar 2023 15:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QqXusgb2Q16a2EZ7Aj9QF/nTU3yfAhaE0j6p/x+GRdI=;
  b=Or6EtnbQfp18JzYL2S7mp8CqtXfk7gmfZwpII+UviA6iZE7ka6xuZRCz
   C/lfyRscAnJcJyYno6msuBqFHVjV0JifuhiCGkAobprj3wlKh5JskFN4O
   NgQ20+3Ow5jIeilZv5FqzVrZkM7gEcRDE7SMOO4WjAJxdjcBfYjUvGJeK
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.98,301,1673910000"; 
   d="scan'208";a="99746938"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Mar 2023 17:46:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id F06D0E0B4F; Wed, 29 Mar 2023 17:46:25 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C1E35E0B2D
	for <cocci@sympa.inria.fr>; Wed, 29 Mar 2023 17:46:24 +0200 (CEST)
IronPort-SDR: 64245d50_KF5GRCTPLFjH91KI/L6cR2/xDyKWnNmIVZ5Yxvr45+SANRz
 iW9XiCQgg5XZby5BdKf8gYuQVqm7NxEt2R0eCpw==
X-IPAS-Result: =?us-ascii?q?A0GAAgCDXCRkhwQP49RSCB4BAQsSDECBRAuCLoFLLwQLR?=
 =?us-ascii?q?oRTkQEuA4QvhyyMIYQCgVaBQD4PAQMBDUEBAgQBAQMEOIFTgnMChTkCHQcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARoJFwcOE?=
 =?us-ascii?q?AUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR1M9AwMjB?=
 =?us-ascii?q?BkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHrix/M4EBgggBAQaCY5knH?=
 =?us-ascii?q?ywiU4FeCYEULY0FhDAnD4FVRIEVJ4NBhB2Df4JngimHVYcZiDIKgTRzgSAOg?=
 =?us-ascii?q?T2BBAIJAhFrgRIIa4F8QAINZAsOcYFKAmRMgSUlBA4DGSsdQAIBCzs6PzUGA?=
 =?us-ascii?q?wsgBlhrAgkjERMFAwsVKkcECDkGGzQRAggPEg8sRA5CNzQTBlwBKQsOEQNQg?=
 =?us-ascii?q?UcEgQ18CgYBJiSda1M7QwkmIIFkkliSQJ4ONAeCKIFVgVkMnwwGEy6XCA4Gk?=
 =?us-ascii?q?iIBLoctkA8gp3qBYzqBXDMaJIM2TwMZD44gCwENCYQDj0g/NDsCBwEKAQEDC?=
 =?us-ascii?q?YVGAQGDIgSCVQEB?=
IronPort-PHdr: A9a23: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
 oUDQPlXWQ5tfhv1IltoFpoOLcUuNg4=
IronPort-Data: A9a23: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
 D3VxpE80tVdDH2kqSb/K8FXWdta+84=
IronPort-HdrOrdr: A9a23:Zg1WA60qJpvgCBqYJ7W9GQqjBEgkLtp133Aq2lEZdPU0SKelfq
 GV/MjzuiWftN98YhwdcLO7WZVoI0myyXcd2+B4AV7IZmfbUR6TXeNfBPzZsljd8kPFmtK1rZ
 0QEJRWOZnKF0Fzicu/yAOkE9AmqeP3l5yAtKPk1W5kSQwvU71t8ws8KgvzKDwOeCB2QaEiDZ
 KZ6458qyG+dW9/VLXcOlA1G9Lbr9nH0KnrewICGnccmW2zsQ8=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,301,1673910000"; 
   d="scan'208";a="51618500"
X-MGA-submission: =?us-ascii?q?MDE3A/lvJLzt7MtCU88O8JSUw5IrOeVYt0v8R8?=
 =?us-ascii?q?W/LwBlDBtBdQ1Te80TOFrSswLE5CFbO4ruz7W6a2QNU91hwuWM/drAxV?=
 =?us-ascii?q?lG/fE8fzNfI/nMmczCAiE6VWTrUx3YqMCDtm4NyTXNsXPrNdZkZ5bwRx?=
 =?us-ascii?q?u361ev+cygmtgiXEDhkfXSEQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 17:46:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680104765; i=markus.elfring@web.de;
	bh=QHAQnzdIquDqwRABuc56SVU/GkIbnVJVhBApNNjLpso=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=PEbRcDwnRg8p+w8mdC/skGyzQtTd4KF9PMrrE9Se0vuYQy2Fl/ZH/VyskUKLAviOG
	 daCZpn8ckefZn3nNiDGeFchpAJMWQDADDHSahQw2RgmMyOL/UVfelrv9BI3Vkrnsfg
	 Tavr8fJ1QDuKEl2kjoAGFUkDvEqSA9e2tzPHIPhVlpuwt61U7Ozjk0VDKbUtmiJI1o
	 jn3xd/wv08xNsQ/fKXb03X5Xpki3XVq+9r+o0y05V7umAatMPWWW22h9dttR65PFhy
	 XCHDNuaNkReNW8aI5wrg0qCtMiMunStM6m+cO1Uitj7NpNOyILfjXjr1/35YPPYoM4
	 2XKspOMJ9W7nQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJWoe-1q1Gjt3Bg8-00JrRL; Wed, 29
 Mar 2023 17:46:05 +0200
Message-ID: <aa867594-e79d-6d08-a08e-8c9e952b4724@web.de>
Date: Wed, 29 Mar 2023 17:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, io-uring@vger.kernel.org,
 Hao Xu <howeyxu@tencent.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EGhKk2m0VheZp1jFC3UK/ieBM5AeXLnyq40hdR16Z05m4VUMQ+C
 u92g5ywLfea7hCUAiF8dOoCfGnpv0GP+eUFFmnInqttUSJXohPCQ3T10cyf9AABKJMRfqcQ
 22XjADu2WVcok5oE5iPLCGFCj2SN01kCIiux7gU1JLR7i1mTHf2yun9/FSsBRcc67hqsfPs
 jiJheIVcwOtiiBW0nyIsg==
UI-OutboundReport: notjunk:1;M01:P0:PCWSwI6MvA4=;PuRsiuTYkk0hkrtgXTzK2URg1Do
 VpsSHUIuL9xcmnRwpjciNV+Ndy0cntoV66qskueKIr98TrXNgCHW0NOEDI1PyThAOcX3120lm
 ujBvRO/vGQEHN/EN/xwrmNkf5iM+6dTo3g9yYI3fXPqRFj6QUQUX0AbWkssKqiP40Lwdc3VSg
 FWGdirHfD+tGXZGasOWA4jNeKYGutl+QEPtkOvB7csw3QmtrqHhFQJDE9+7tBOfOOG43LqnYi
 bscqt7fNTF/3jorxBaNud6YKqIoZvHpkrR2+A5OOW6B9gZ6CxLfrtZWR3rY80zh9TMqUTr4Oc
 aPWec/JVDcUOK1S/+VuoC0lroya1eUDEZqgy1Q2r+h+W722v05Ru0LV7pMQmbt9tnhjdlbTbO
 +jZpLt21r1DrRIrlYMQH9E7YWx80qRn/rR2q3IdIwe3LOh0qzWAR4CPQze9JtWDHZtYF90VM9
 37iQhAhB201bc5/Byb+vTc8fxor9PLKxYb2JaMACWpr088+mgoSgNqVKxvuTKk8dJ4/aPt4EQ
 B7Rj8Nu1I81zkXElZOEI65smGSQsD9s9bebEd4nWAT1RQQPpSQdZX73Nwh6sIvE+Bq3pg8V8p
 2rUBmngx+zbN5oy7SrHcUYfAX6RzdCLgiqu3+6Hj014qdf5ICYDrygNv8QqHaPiz+yOaPV1Bu
 jqRWjNDr0gGkGd3QyfYsfsqFNpirbcJLvzBQwuzB/MVDqNPOX1aKUtOY5Ihz9JCKkcfsFZbol
 J9nlj+a8c2D6Y0igcdXzCgGmFpBg1bH748SE2B4N8g58/7KBiE3eFZWd4yOC2PwcQ+x3AYdaP
 EcANjLv+kndWYR4+69M6BsEyoQ3cGIv1oKxwCTjWahg6RhAro3prvIWr5LDTYogPuaYD5iCCb
 45V2qbG75XBD3WIkQZSUxOgdRvH5egltDnV+3+W/egFT1ptIZhjn/w4P7
Subject: [cocci] [PATCH] io_uring: Fix exception handling in
 io_ring_ctx_alloc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 987
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/aa867594-e79d-6d08-a08e-8c9e952b4724%40web.de>

Date: Wed, 29 Mar 2023 17:35:16 +0200

The label =E2=80=9Cerr=E2=80=9D was used to jump to a kfree() call despite=
 of
the detail in the implementation of the function =E2=80=9Cio_ring_ctx_allo=
c=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed memory allocation.

1. Thus use more appropriate labels instead.

2. Reorder jump targets at the end.

3. Omit the statement =E2=80=9Ckfree(ctx->io_bl);=E2=80=9D.


This issue was detected by using the Coccinelle software.

Fixes: 206aefde4f886fdeb3b6339aacab3a85fb74cb7e ("io_uring: reduce/pack si=
ze of io_ring_ctx")
Fixes: 78076bb64aa8ba5b7207c38b2660a9e10ffa8cc7 ("io_uring: use hash table=
 for poll command lookups")
Fixes: 9cfc7e94e42be9c73072606b84d4574a0a2ec270 ("io_uring: get rid of has=
hed provided buffer groups")
Fixes: 9ca9fb24d5febccea354089c41f96a8ad0d853f8 ("io_uring: mutex locked p=
oll hashing")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 io_uring/io_uring.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 536940675c67..fceb74d7d851 100644
=2D-- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -291,19 +291,19 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(=
struct io_uring_params *p)
 	hash_bits =3D ilog2(p->cq_entries) - 5;
 	hash_bits =3D clamp(hash_bits, 1, 8);
 	if (io_alloc_hash_table(&ctx->cancel_table, hash_bits))
-		goto err;
+		goto destroy_io_bl_xa;
 	if (io_alloc_hash_table(&ctx->cancel_table_locked, hash_bits))
-		goto err;
+		goto free_cancel_table_hbs;

 	ctx->dummy_ubuf =3D kzalloc(sizeof(*ctx->dummy_ubuf), GFP_KERNEL);
 	if (!ctx->dummy_ubuf)
-		goto err;
+		goto free_cancel_table_locked_hbs;
 	/* set invalid range, so io_import_fixed() fails meeting it */
 	ctx->dummy_ubuf->ubuf =3D -1UL;

 	if (percpu_ref_init(&ctx->refs, io_ring_ctx_ref_free,
 			    0, GFP_KERNEL))
-		goto err;
+		goto free_ubuf;

 	ctx->flags =3D p->flags;
 	init_waitqueue_head(&ctx->sqo_sq_wait);
@@ -337,11 +337,14 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(=
struct io_uring_params *p)
 	INIT_DELAYED_WORK(&ctx->fallback_work, io_fallback_req_func);
 	INIT_WQ_LIST(&ctx->submit_state.compl_reqs);
 	return ctx;
-err:
+
+free_ubuf:
 	kfree(ctx->dummy_ubuf);
-	kfree(ctx->cancel_table.hbs);
+free_cancel_table_locked_hbs:
 	kfree(ctx->cancel_table_locked.hbs);
-	kfree(ctx->io_bl);
+free_cancel_table_hbs:
+	kfree(ctx->cancel_table.hbs);
+destroy_io_bl_xa:
 	xa_destroy(&ctx->io_bl_xa);
 	kfree(ctx);
 	return NULL;
=2D-
2.40.0

