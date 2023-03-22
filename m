Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFE0C6FD1C
	for <cocci@archiver.kernel.org>; Wed, 22 Mar 2023 19:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=p0zdzFas69AlWYBsIqlFxDUwcfJIP9/bJPkki5uZfRA=;
  b=DGAr/ICZYMoTJfaIIDZ0YR3U2sgmaJ0ZGO4wrhpS3Nt9SxYyIxZ+3Ysg
   S9RgQ9DeMcRNs8szSY9LNiS5yuiHBNw6wTLQ0cC9+RXrLpB0iUoJqomdh
   BDtymNF8cxsCy1pBY8+ZtFJ0zvgu724kJX7uvFHbc51f70cOyk0HXS2fv
   w=;
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
X-IronPort-AV: E=Sophos;i="5.98,282,1673910000"; 
   d="scan'208";a="98601321"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Mar 2023 20:20:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4F972E0D3E; Wed, 22 Mar 2023 20:20:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C4B0FE0131
	for <cocci@sympa.inria.fr>; Wed, 22 Mar 2023 20:20:53 +0100 (CET)
IronPort-SDR: 641b5515_NlDqXFuqbui+a0e0o07QZr7NSVoP3KOpL6V1uC5UL+BhJOK
 RNv433NBBb14Pp3t/CEL5CWOHdxJtE61G9kw+XQ==
X-IPAS-Result: =?us-ascii?q?A0HXAADVUxtkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYItgUsvBAtGhFOPCoF3LgOEL4csjCGEAoMWPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wQ4gVOCcwKFNgIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AQBAQIQAQEBGgkXBw4FCwUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARICR1M9AwMjBBkBAREmAQ8JFgYCJgICVwYBDAYCAQGCeoIoAQMxB?=
 =?us-ascii?q?5YunBd/M4EBgggBAQaCY5knHywiU4FeCYEULQGNBIQwJw+BVUSBPIJMdYgcg?=
 =?us-ascii?q?meCKYdXhnGIKwqBNHaBIA6BPYEEAgkCEWuBEghrgX1BAg1lCw5xgUsCZE03J?=
 =?us-ascii?q?QQOAxkrHUACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhs0EQIIDxIPL?=
 =?us-ascii?q?EQOQjc0EwZcASkLDhEDT4FHBIENgQEGASYknG4gAVIhEApMJoIEkliSQJ4ON?=
 =?us-ascii?q?AeCKIFVgVkMnwwGEy6XCA4GkiIBLoctkA8gp3qBeSSBXDMaJIM2TwMZD44gD?=
 =?us-ascii?q?A0JhAOPR0A0OwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 xZamdvF
IronPort-Data: A9a23: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
 T3TFrMc8/RxLlxUqT4v28GG
IronPort-HdrOrdr: A9a23:NInb8qw9TT9ygaZ9w5ymKrPw+L1zdoMgy1knxilNoNJuA6ulfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebnN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,282,1673910000"; 
   d="scan'208";a="50966010"
X-MGA-submission: =?us-ascii?q?MDFG/RIso0Nr56g49NK3UrXGVsbAhTox8T2jaO?=
 =?us-ascii?q?2OQEn836ChFDZA5OCiqazc7/zyyGqLKJO2Ud2IyZgxn1Yo1o74UwzxGr?=
 =?us-ascii?q?85wHeWzNnOz6CLXpdI3uUPKPL1OBVDJW5KLeiYJdSyMcJJHbCRUkieI+?=
 =?us-ascii?q?cV6bcxMhVO6tBQWfB1rQHKhA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 20:20:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679512845; i=markus.elfring@web.de;
	bh=p0zdzFas69AlWYBsIqlFxDUwcfJIP9/bJPkki5uZfRA=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=ENMltXPOdufSjp69Ny0SOQ+zfuXJMckGRKspL7izrY+qyRSk/+I2RAndgqCYSzIgy
	 EWnrNhFBMYrmmYl1bzGm1KOS2AX1bwviV7yFcwN+bVvPst/q4XTecwhlHlTf0W4ljq
	 mqxySq/5k123wdiNWamwJq4G9dLG6ceOQs2uP0cIAuBbMhu1eiaAU9wQpib/0Kq1vY
	 3+vmUcItKbNwrPXMZLSEehe25IZ6YGPO4CyYTqOACEZIjoBVkalrSOCwYHrLxFieKt
	 21eXfzO77b03CLIr6xPVNhz2K7Q9WkLfPrWomu10a4WFMmK5qK+mxrBDFQrrjT6Jqz
	 +/U339G0w6lTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBjMO-1pmnmi46kG-00CCEu; Wed, 22
 Mar 2023 20:20:45 +0100
Message-ID: <cebfc94f-8fdb-4d5c-56ee-4d37df3430a1@web.de>
Date: Wed, 22 Mar 2023 20:20:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-btrfs@vger.kernel.org,
 Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Naohiro Aota <naohiro.aota@wdc.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vktxbxAWdpGnTpGkNP+Hmhuqlrn2SPxhImahaavTiduspIR47rY
 Dp9jcFNy4W7vDYxxbLtDK6sHlyB6BRkJotAdR+Ij/D+7c7lsMTrFpIttGyg4RpxGMoNtns8
 wnFjDQWNxTSrWMF2b4Lj7WtXPWZTb3cx6cbhu2trDAIXdfsJDfRDYisYpJiex2dk8BnYF28
 qdcLjfhUQTeIYO78PC/Sw==
UI-OutboundReport: notjunk:1;M01:P0:5ekZ1LmTIiY=;mViOimcUMrYKaS3zILpag+CzsUV
 wHVhHMXkQhwFd06N3Gs6FRICakCos3mnIV17D1AFpv7kaKfk9lighHONX/uL+YK9DuhDEg/+0
 Ec3G1vBhQoHhWSXpoPMKHLpL7EAcM0Nj+djgDXc51p36eMub2TS/SinKQgaXjYlWf90AKYoPn
 Gd1hCC8HKJYuwgBnw2WCBFfKT2MrVXyfk3jp8IBj670d37Xy7XsXy15StfVn8hfSnyjOO//1V
 l0ANJfefFoTYwcqPNOLbaFrB+knjGivobi8C5vjBsxcy2va+UUy5nBAS+hkzLLwjg63gYGRg/
 paTSz2WaeJpr+f+prO9QFI6wwq+0qk8XSL50kfUkLLjPVGG3iMnklylnKe9LcqlNBuKsdui3F
 T5AajWtQplAGlB78B2dcdr5QGGgpIu9ddHT5ebkyn7B1GTUv2FEdo6sP25Wg0RUlERNOlPJPD
 riMCX4PfOYRS0HW/691e5ig8uA85J4rmbcEila4UdT9R9h6RDMBjrClk2TxrzCEHgQxTXIWTJ
 CyfWyfLXKh8rt8LU5Mct0rCO5SJnThHrLJGyhc9+S5BJtz+AxlLpJ4nk20kG6SCXTyJagpb+k
 5YKY62ISRIBh9YPm2cNKOSDcD/wpNoPJkKDRw3Dll7QXI3mmO7Bo8ErKc+zeFaWFuMr44sUFO
 KMnmeM9fPEaWufSiRAXFGpCt4e4NeWALVzGIEuqIlKGi50QIsA6T81GLMkJEhKWR7iI55t3cd
 7JQK7qnBdu3hfB+0xCshD0hjm6WoVdUoOJMToOTcW9uJ+KgtRIJqVOTTY3e7K5abRd91wCyBA
 GnkFf7bBe0HLh4DUydlUD5suBk3OUWgjC324DHpTSkodZXbp/oZmD3MyW/sOW2vsd9QfSlieG
 2TafBKNraQjuncK0WS+w5QCB/9GwQZtQ9x9eM4c8RzlNLfMjp5QDNGEwmT4kqX6cRNnSJgZkm
 Wzh6zTLMOfIPAFBnXBtXJ57Jy6HMkU5jHSuRnmp/RaYf2I0hsJPeY/ix+tnOWUX0yAnweQ==
Subject: [cocci] [PATCH] btrfs: Fix exception handling in
 relocating_repair_kthread()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 911
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/cebfc94f-8fdb-4d5c-56ee-4d37df3430a1%40web.de>

Date: Wed, 22 Mar 2023 20:10:09 +0100

The label =E2=80=9Cout=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function
=E2=80=9Crelocating_repair_kthread=E2=80=9D that it was determined already=
 that
a corresponding variable contained a null pointer because of
a failed call of the function =E2=80=9Cbtrfs_lookup_block_group=E2=80=9D.

* Thus use more appropriate labels instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: f7ef5287a63d644e62a52893af8c6cfcb5043213 ("btrfs: zoned: relocate b=
lock group to repair IO failure in zoned filesystems")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
=C2=A0fs/btrfs/volumes.c | 13 ++++++-------
=C2=A01 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6d0124b6e79e..de11ad6c8740 100644
=2D-- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8096,23 +8096,22 @@ static int relocating_repair_kthread(void *data)
=C2=A0=C2=A0=C2=A0 =C2=A0/* Ensure block group still exists */
=C2=A0=C2=A0=C2=A0 =C2=A0cache =3D btrfs_lookup_block_group(fs_info, targe=
t);
=C2=A0=C2=A0=C2=A0 =C2=A0if (!cache)
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto out;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto unlock;
=C2=A0
=C2=A0=C2=A0=C2=A0 =C2=A0if (!test_bit(BLOCK_GROUP_FLAG_RELOCATING_REPAIR,=
 &cache->runtime_flags))
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto out;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto put_block_group;
=C2=A0
=C2=A0=C2=A0=C2=A0 =C2=A0ret =3D btrfs_may_alloc_data_chunk(fs_info, targe=
t);
=C2=A0=C2=A0=C2=A0 =C2=A0if (ret < 0)
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto out;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto put_block_group;
=C2=A0
=C2=A0=C2=A0=C2=A0 =C2=A0btrfs_info(fs_info,
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 "zoned: relocatin=
g block group %llu to repair IO failure",
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 target);
=C2=A0=C2=A0=C2=A0 =C2=A0ret =3D btrfs_relocate_chunk(fs_info, target);
-
-out:
-=C2=A0=C2=A0 =C2=A0if (cache)
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0btrfs_put_block_group(cache);
+put_block_group:
+=C2=A0=C2=A0 =C2=A0btrfs_put_block_group(cache);
+unlock:
=C2=A0=C2=A0=C2=A0 =C2=A0mutex_unlock(&fs_info->reclaim_bgs_lock);
=C2=A0=C2=A0=C2=A0 =C2=A0btrfs_exclop_finish(fs_info);
=C2=A0=C2=A0=C2=A0 =C2=A0sb_end_write(fs_info->sb);
=2D-
2.40.0


