Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FE3C6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=m/szNKkZ3qOM0LjUsXpeDJqvdYqkgvuWo3Wa3baCmPc=;
  b=FB744JQU+UYgexi9WDH+72fp2sA+cKkbuRgbRfU2lsN3mLit93xew4RU
   X9mRqQsX+/hTnf1ClxZXtP90QJIMofzQ0/OdCon2h2ZSTed37anEx+5vR
   fPzHqqSI6GMAkZoLpdECt1LGkLtaiHWwN07z6rQZ/93Q3rVxEraCzic4S
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99046810"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 10:31:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 722D2E0D44; Sat, 25 Mar 2023 10:31:13 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1C0CDE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 10:31:10 +0100 (CET)
IronPort-SDR: 641ebf5d_Tauq6x+Cm8M4016ocBTWFmSIwAzNiS7l7rt/Is7F4A9EKxf
 o+uRc6PuwqXSokSpkTH9MDBbIoicp5W3dtBfJPg==
X-IPAS-Result: =?us-ascii?q?A0FDAAD3vR5khwMP49RaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YItgUsvBAtGhFORAS4DhC+HLJAjgVaBQD4PAQMBDUEBAgQBAQMEOIFTgnMCh?=
 =?us-ascii?q?ToCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBA?=
 =?us-ascii?q?RoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR?=
 =?us-ascii?q?1M9AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHsSd/M4EBgggBA?=
 =?us-ascii?q?QaCY5knHywiU4FeCYEULQGNBIM2eicPgVVEgTwMgzWIHIJngiiHVocliC8Kg?=
 =?us-ascii?q?TR1gSAOgT2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAmRMgR4lBA4DGSsdQAIBC?=
 =?us-ascii?q?zs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPEg8sRA5CNzQTBlwBK?=
 =?us-ascii?q?QsOEQNQgUcEgQqBAQYBJiSacQIBgkcgAVI7TCYOgXaSWAqSNp4ONAeCKIFVg?=
 =?us-ascii?q?VkMnwwGEy6XCA4GkiMulzwgp3qBZQM1gVwzGiSDNk8DGQ+OIBmEDI9HQDQ7A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:n+JBnK6FUt1cE7tPbgPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51220344"
X-MGA-submission: =?us-ascii?q?MDGpZpLNuM6ViV6mJ87ZkFYXgpL/WLyOqRpWan?=
 =?us-ascii?q?0mQtr3Bq9VVdBFSech9fPjpkFVwzjdEsC1BwUEcoTtX+yWQUQPwAgOPC?=
 =?us-ascii?q?iDdWOk/pDzzk/M0fmoU8jGOZX4TUsMU9h5oJo2ozdLJl7ai7bcy0osQu?=
 =?us-ascii?q?ooPOgXgg7mvDPVAo48VLXe4A=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 10:31:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679736667; i=markus.elfring@web.de;
	bh=X59gvXczY/HbMv41gvLqWjC0cVVRXFce7u80dUK7gwg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=jhmxx1jmc1svma2i4GtN4HFVBUSDTMi1cjMOF9Hid0S4tD6iFhciLATC6JM6rT+0h
	 ejUCIjafah5nIv8Fl69ppx8QMkKluEIyjoFqmxFrxfJGBbJG/g9oky6ueK7JdPvAba
	 M9RNpS1HstrUAl+BkTlX0GW7lpzalIO2ZqKsQwGbOs1nI+ZzW0Oqzbmio3xSv/Jpv2
	 o6OJVDvxRNk4xvUby+nBJ7sM1ZOUsFf5fN1SmFhankhAxXmWjdwuQhaC2CuhISSMV8
	 Rf5c4qexW53PD+Di+F1ufx+udYgLDVMqy4Xyge9GEP5I355YgfACyvIedOOxZFi6/9
	 RuucsPxMotEMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7xaR-1qaniy2nkR-0155RH; Sat, 25
 Mar 2023 10:31:07 +0100
Message-ID: <d0381c8e-7302-b0ed-cf69-cbc8c3618106@web.de>
Date: Sat, 25 Mar 2023 10:31:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-bcache@vger.kernel.org,
 Coly Li <colyli@suse.de>, Kent Overstreet <kent.overstreet@gmail.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e33f264a-7ee9-4ebc-d58e-bbb7fd567198@web.de>
In-Reply-To: <e33f264a-7ee9-4ebc-d58e-bbb7fd567198@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lZBO/I/gxgvdBsxRKteYdAnbsuc6NcdyMvIp8REETlOGDLtkSkY
 bEZibFXTgkdfoDCUNYbYmDq5UVj3W15diKk9ZdVUuzt+O6Ax5gyLTRsMQc04QO48/aiQ+FT
 Teqyr6x9srpnnSd/IO/YhPO/621rXRQ+z4+29C3Bd/hiKBfCzZlv0qdRJaL3d0qX8nUmRa7
 eOHnOZDR4XMxN1/GwlXeg==
UI-OutboundReport: notjunk:1;M01:P0:aNXA/AWvV7Y=;zuuBmjdbGTkQmM/vMh8mhEqbrrb
 PLrBg6NZVxcUiUE0v7tyocg4AwgBTNwuCwxlfB8G0tCHFh76AU6Z0USB+hRhFdWcLZx8UPG7p
 09NoB6NKFyfzsywK8nXX280QjtZRhm1UIsbD2l8yCiTFVl68EwRba5j+HJTEm1NQs0CP+p/Yn
 H4C4G6uUQqdoIEf6FLD+S6iXsu3betWVZ59QqoVbEzU8UpvpidwZAjnq5zGgX/rLr6jXE9Xj/
 MK1tQSexkWFQJKBR1Mrxa2biRUlOP3lWovyHQrTVl3aShdn4p+GXNOV4BE6fhVjqi+N8CYlL3
 fRQQT6QV1n+iIpLOopHYc4Tgq0ztm3SX4IybELLmNbSWO+B0tdebt510fs8hR03guumwoJjie
 O9PGKgzKCtZkcbfr8tvJAKTR7oSjY6USpG/nk1OcqYEz16IUZVBX2JbBxcWVCgX1SSnnoHT7p
 tAWU9lLfscVDvEYcnE5MMrqsMsbZ5CvKvGadVnhcm5+e7uzUYQfM+uorTqCRiq8FYD6mj2b9/
 ko7tAdAdHj/d76NpHmRySIws9rvOSvDlt7q8JykYvfCR5OKBFjX8E66aDPfm0Pm47VlV+PnYk
 9ZnqkqD+lTOAZDbsgDoO00k4aZM3I/Dab/pyMcU9OnxqnOgfkKGdko4YBvJxkEqGwNW7lDMxa
 m7NFpsspusbonTaCVtK73tEqwVGSpYQhjG8GlpuvpqkyCWraWfXmJOhDxSUWtguIJ8/UCSwDu
 adk9A1sRC+dKgZoEsc3IJRvpbO99Bhkm7QRqrMS6RivacA2lgGmjnc9iCSn3ElI38IniiiITG
 WpHPmum2xminv1LmqAosy8Z0TyFuCHSegtQML8Y10uWuEZZdJWJGymUeZEwVQTfzZuYZzPgPj
 85+KbygKhVt970M/N/gPR8wt3gYKxoqkZQ4SzbEa1f2Ohy1OhtjgczRxi
Subject: [cocci] [PATCH resent] bcache: Fix exception handling in
 mca_alloc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 932
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/d0381c8e-7302-b0ed-cf69-cbc8c3618106%40web.de>

Date: Mon, 20 Mar 2023 13:13:37 +0100

The label =E2=80=9Cerr=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function =E2=80=9Cmca_alloc=E2=80=
=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed function call =E2=80=9Cmca_bucket_alloc=
=E2=80=9D.

* Thus use a more appropriate label instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: cafe563591446cf80bfbc2fe3bc72a2e36cf1060 ("bcache: A block layer ca=
che")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/md/bcache/btree.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 147c493a989a..166afd7ec499 100644
=2D-- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -921,18 +921,18 @@ static struct btree *mca_alloc(struct cache_set *c, =
struct btree_op *op,
 		if (!mca_reap(b, 0, false)) {
 			mca_data_alloc(b, k, __GFP_NOWARN|GFP_NOIO);
 			if (!b->keys.set[0].data)
-				goto err;
+				goto unlock;
 			else
 				goto out;
 		}

 	b =3D mca_bucket_alloc(c, k, __GFP_NOWARN|GFP_NOIO);
 	if (!b)
-		goto err;
+		goto unlock;

 	BUG_ON(!down_write_trylock(&b->lock));
 	if (!b->keys.set->data)
-		goto err;
+		goto unlock;
 out:
 	BUG_ON(b->io_mutex.count !=3D 1);

@@ -955,9 +955,8 @@ static struct btree *mca_alloc(struct cache_set *c, st=
ruct btree_op *op,
 				    &b->c->expensive_debug_checks);

 	return b;
-err:
-	if (b)
-		rw_unlock(true, b);
+unlock:
+	rw_unlock(true, b);

 	b =3D mca_cannibalize(c, op, k);
 	if (!IS_ERR(b))
=2D-
2.40.0

