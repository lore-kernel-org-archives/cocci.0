Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D321BC5B543
	for <cocci@archiver.kernel.org>; Tue, 10 Jun 2025 08:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=D/7aKK1/L6TUxFINVRm7j9uLR3QIgejbi4oSLH+EN3k=;
  b=HuBzcDcQk813fqCEZ/XZPpUxxrrWMnTh7zD9PoB09bfXgrT0HcMHGa7P
   WSlqFBkSsjEP6oDPCMDHz95UvbCYxMoxdX8YztiwZv1D4Zt8sfYKJxVMp
   mxTBNoSouVgVQt8grEqFOkI6ZoUtxPPDunMPuoP0zTCfcN6mccO28AAPM
   Y=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,224,1744063200"; 
   d="scan'208";a="226019677"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2025 10:55:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1A4C9E0AF6; Tue, 10 Jun 2025 10:55:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A390FE0131
	for <cocci@sympa.inria.fr>; Tue, 10 Jun 2025 10:55:40 +0200 (CEST)
IronPort-SDR: 6847f30b_LhfF4UHoP08vv5QzYLhReNK3KdN5TPXTLX2zfUVuzvDIZpx
 XGS0MDXvIMfzjIyhGc3XyuzwczNBplihnI5yY4A==
X-IPAS-Result: =?us-ascii?q?A0EjBQC+8UdofgQP49RagQmBU4JEgQBaMwQLSYRVj1CCI?=
 =?us-ascii?q?YQ+mAaBVYF9Ag8BAwENRAoBAgQBAQMEggyCLjyLcQIeBwEEMAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHDgkBMYV7DYJbgSyBJgEBA?=
 =?us-ascii?q?QEBAQEBAQEBAR0CDTptBBkBAREnNAImAnMBAYJ+AYIhAQYQAQMyBw0GrnZ/M?=
 =?us-ascii?q?4EBggwBAQaCadd1HywiWIFlAwaBGy6FbYJJGgEFbYoYD4FVRIE8glKDUASBJ?=
 =?us-ascii?q?YEGgw6CaYIogRaBQItVhFdFjk2BShwDWSwBVRMXCwcFgWMDgQ8yPDIdgg2FG?=
 =?us-ascii?q?YISggeCJYU5gSOESStPhSFMWoNfJHIPBxpAAgELbT03CQsbBj2YaINpgRUsg?=
 =?us-ascii?q?QBRd5MaFbJ0NAeCOIFmBYFfDIkHgSaVOwYQAy+EBJNHDgaTApkEgliLL5VYh?=
 =?us-ascii?q?VmBaDqBXDMaJIM2TwMZD5IhM7cmQTUCAQE4AgcBCgEBAwmFRgEBik80gUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 BB5dF5R6KKd52VUj6cnc4SkxmVoJ6+IlnTBh9Q=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:aW4GTKMb6Wa7wsBcTmKjsMiBIKoaSvp037Dk7SFMoHtuA6qlfq
 GV7ZMmPHrP4gr5N0tMpTntAsW9qDbnhP1ICWd4B8bfYOCkghrUEGlahbGSvAEIYheOiNK1jJ
 0QApSWaueRMbEKt7ef3ODiKadY/DDvysnB7ts2jU0dLz2CDZsO0+4TMHf/LqQZfmd77LMCZe
 qhz/sCiTq8WGgdKv+2DmMCWIH41qf2vaOjTx4aJgItrDKDhzOw6LL8DnGjr2wjegIK77c+0H
 TP1zf07KW7s/2911v12mLJ445N8eGRuOdrNYijitU1Nj6psAquaYh7MofyxAwdre209VYsmM
 TNpRA7Vv4DmE/sQg==
X-Talos-CUID: 9a23:OjHbgWCVsRNgLir6EylK81xJWdl9SF/yj0b5fne5WHhNSYTAHA==
X-Talos-MUID: 9a23:B5IoXQT0xBBDO16GRXTIuw5CHdtp3J2+J0kckpMJssCAJBRZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,224,1744063200"; 
   d="scan'208";a="118618662"
X-MGA-submission: =?us-ascii?q?MDFn4fFjBUyz8G7Y9ajIlSfJ+4FjSk4ieGMJ72?=
 =?us-ascii?q?N49BxhiKICWKdQ9EFaUO7GGazqC5QOchw/7rdsId/y+AWEkm/KSXrbfj?=
 =?us-ascii?q?CoF0BTfX6eyV2Kui/458Pqj/GgBZMPp/yag7sxWWxgsvsEqch7UYuMir?=
 =?us-ascii?q?t//Bav/zkVEsTM/e15/lZPRw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 10:55:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749545738; x=1750150538; i=markus.elfring@web.de;
	bh=D/7aKK1/L6TUxFINVRm7j9uLR3QIgejbi4oSLH+EN3k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Z2AGBradBove7mkVt7cokEwkyfmM0ayLL1PvNZsdrN/tCSNoD5WoNrivO6ecdKyB
	 h++yB2UMxoMPczqAJKd3moNFQ8Hk1wDlOEgv36/kzRNV/Md5cBZYB4j4UIBm5gX84
	 Lr0Jv2IGdbNlVIn4t8LQbU8XsZYkOYIV8fNl83TNSts2huwMjVZvl80W4umPiXwNj
	 Bh9uKPM9BUFbFVAS73h5ojvuCMd2X8jQgYhd7uq15+P1tob1qe8JEQcpv8veJ/NbF
	 Y8rPP1eprGX1GGqqmWOk260BInu5f+TZIlxok/3/LidFN69j5hpfe+qzbGiGldquV
	 g2Z60OlfBiR64cGnxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.183]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHVen-1ubmoa36g5-00CP0T for
 <cocci@inria.fr>; Tue, 10 Jun 2025 10:55:37 +0200
Message-ID: <90822099-5434-4421-a611-785511926ecb@web.de>
Date: Tue, 10 Jun 2025 10:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Ws91kJNYCNqky6+s4dKmFzOVBeiNmi4q54Qjw33q3bEUy6tV+F
 RaYFrtYiVF8uzZRE3njmkajEddo50UtT8SSuuTme9+6CKW3XRp1rYyuGFg2mi+h2KqZxaul
 Dqrgwtf3s9K0e0vH6z+1CmSXxwWQOu7h+1WH9O0GTNunz5w08z+Cf3nOrp9WiE/ZamHIlwZ
 t+F2Edn1NjklwQRSn0Q2Q==
UI-OutboundReport: notjunk:1;M01:P0:hnm9hWCUqxk=;uDr7G7PamJ/jpMcxWAI/sA/KpFf
 e7/lWgN/YtajBC/VDj3MQ6XW52zCggfZ++xVymg6YQFJQAFLN5FvBcuCuEg7R6IZ0eh4zHQjr
 Rz0RJyFRUWtyzHqfgjWw8W96fb0yRDojEEcHyKDbhPqA6IRoteqgmXQ+18467yqhwY0r3JqEg
 1DwdK1tSdcC38KxBAuXQM7QTwLUBhmvd/qAGHpAVF+dgbWm/pdAhFFtldYzUo4C5Ef3EoN4lz
 jUdF0kES2wA6Rksm/gLAVMB2ZoqN2QxyZry+a3N3YU+ivHWbsSRVpxjGAm0foN1Mi5RjEm2tD
 dBH/qGB73XK5pYorZ6GwAIjHrwaUH/MWZveCkxfQXPeUFCyizLxjeeOqBds/hVs9eos80IN4U
 l73vD/SdEESvXiqeucPUCqVGCR6vXAeZ0A5XmAoZJoy9K99vqPdCi9ZUxhJNVfqm446Q53kQA
 6VJ7hiE4QiQG608FkPEfq3+ZSDDKA+mIoE998E+NGRXGi1LrnNClLgXEGlHm/Uf6gcoRBsgJI
 cnAZYUaVJjRj9bo194iCUPeQqKWQ8JrrArsC0+rH6+Qhvc9l82I8Xy8aXLCyeJNIMP+NSTw/S
 DUju45LEVlXlQd6+mrnRxt3v/52VkFwiJH3+MtmDu09FwXf4K2TG6YxuLgJ0IDmG532FbiZtR
 ygkuvHT+w9bTu2Flg9VNAOJLTRX1w8W+1synEIwEuQ9+Wg9/xGow/or63c7idofNTECvwOPvD
 k6+oMVFBY2fr/pJUSpWpYcpibcecVl6EimpXk8/Q/r7/x0U4c91QuCOKR2t9oqrQal3LU5nfS
 /iVrXdKw7xNZEI2HwaaLC5gvmaV9gr8yyV31f9mCi4XqqGzmeJFiKMZWi7Ie2M45dzjTwRZCS
 GNjKRdzZRVGVJZ76LVvXO5EkBkvpDA46SbtdiLFF9lQl4D24m8jI9uagd5AEsl913D+6n5ouW
 wLGaNIpoPvcJ+zAEvVpO2Dhg8vZNI9uIm5UX+tvXSPpYIXkyBCSk5aZdvCg0La05WUojdD/Qm
 kNV8+zoimaXTJlSkMF0gS5yJWjCeMOIRLXTazTbS4xaasYk/vNEiJHibYQFZaTU7WOXU3QSzf
 QL3edvzrkGF+6oJtl1aEgIlA67ZRXsle5aHRbrPklv2kPiajz0lNYHZ10WXLRTeopu+6+eezg
 3KjU7pRGDky9AqhbNIUuXKaA9NeQqLqsJFgxuLBTKhmyaZcPBQAJ1k73EPvV1QXO49Xs+3Q7s
 A2riPtAUG45Gso2gv5UWgdNOn25ve9iiMbCfaMDDSj0VBk0NOdYMFbLmsBcGITyur6o1YW6QW
 DuadU5tWA9Q0wrr/MhpKrttjuBY56S1v1urwW4NvzYd2QTPF71ixHmleDN6ZMlOnUM1yNFa8P
 Pdgmh9eLuxaGmoatTLRTqvwxC7XQZJNiz0pCXgOl8i3gS5CYvL7BiCP8+LGrgRw7KZQJ62YH5
 rjDbIU34FhrWd2AeSmlbnirh+xJCvtqCyUzS/ngD3/Mlnw2zR0sQMeHCxdrfntm8m3Ueh9Fez
 rVszz9T3IJUfCm6Ds9HvFpDrDGTPCye35wGk0WXSSJPYicTuQ2S7WaYWLEsHA6vIeWYXxDVLE
 8mJRTwSOpGJ/3zVH3pxq+eWgpJHJh8XYYTtaTM0Q2l0G2/NLGl45OXbYYLBepA/fQZrit5niz
 SeI4RtB57PVbmbmMnKBHmZ33cnu3bvax31tq53C7YZzNBzB0T+JOVJe9NP51gH+CTsN21ytCh
 XOZdhTNY0jk0MBI7gTTwiEI+LlmuMAc5WV7Kz6mOnXZVpWHfPCj0iRmcpQvNsNfx/ajZK35jw
 63uoS3TV/E4Umq8Np/CqA0V2j/f/4rJO3mfdTUziroj5bdedQya45nxwMtlGY2P+3PZSUco4m
 wls+BtGXfX8KXUwBl0amtQ1tsCEVCuvFXtsp1XryW3aHdUwIi6viNDj+xFhCMlBNX8fi52x2F
 6JHTiW2d788JSrVeWzqcbSJtnY/JSutwIGhkLpTVo5GsxuoAKmxP7u+B+CG1+RNp+yUDx/6tT
 9f+jE595p76zA4tMtt/PoLOKTUJSACQlzDK2qp4rc+5f8510uSjJfa+mRNtzhWHF0WwBuy9oy
 mft1/rdcMDvGAf6MV8Czp0Qi+pJSusmk9/T1ydH9WG6RiVg7ByKEp2EOQSCMM5jOKWsVXZVPK
 e2iayAvHT9/PLYIl4W3bPzAd9GfjbFih8b6sHT72y+5vHC+gjZ653OwLuFArLiWdDfyJOQxFc
 Io3YtprNzztC75AWNLaHxmTc6Yv63A5Jdy5DP8+wlu7KgCQu6le9CImJuoHKrvj1Lz2sE9bqo
 PUV9oazd8Ua5K6rWbdQN6EllcGTGIIqJR5bh6BZ2nA0aA4B5OQg8lfZfP606d1Z1sN13PSAB4
 wNHDNw20fSecbuvN/2iAEEROiykc6cB/tjqam2ua9sqVOIyMneKhm4W9QO+7m9qnApv4ki1XU
 eDTyZS3vdcI9FpMisjQS+H3ZYL/VPP1BX2IMaNot1DacnEK2TCt21RMWhWWJ+++dn53DEQlY5
 g7XowRLWOPr5U3dGuNNj5CwuGK6BwKDXo2TkN7hy+BrE9CvkWVMtYQ0yeR9Fwu75YtjQ+ph62
 DYqXdKKcBw21dIMTKXnqxADJ5ty6qAkVx2U5kZpYzcqDQTvvYcSVtijokyEeCshQuL1hWWx3w
 DPGorZ4g3Hw4VF6D8wsfl0N+QVbvrnYPl9q4BX5lldGEgXbwxBG0joKG9kZ7TisN2+6dzJfaK
 AAlnPlP9mpnYTY0jzrsh733MhzeQDbZBTWkF/8kALOtaNRdd0FUdLuEMPt0fuUdiCwWsYrTpB
 InMlKDcn9tSgpu3lOPzUKZWqDEvsST9jMDPaDWazc7KGBLzjL91uAHjxFBIl8bBL/VvzcIzgW
 kAmjdz9IsF31stE5zk8j3uRSqBiEJVEAaQh16txPx/deofqicSFGO4ptsgWQQl3bcfcRrkqKh
 r5eL9sVZCniif+pbIDixofbTwbN++j3l8rj9eYksCiUqyPGAOkDze88XNGOVcDpJJz86pE87I
 RlS+rwmEjaY9PPrpEsJchS8BX+okqpSyeaAakEs48htw/Et0JfbevWn3pPFfGWVKCwXjH02tl
 MjvFF/b75tBW63svStJQ2IJok+Tm/yWKfJ3CkgLExLcNnfEzBE18UCsoJtC7amcpyr2jiqRtS
 irw2upWc216iqpGSZOdlnqYN+fDjIpw2Oi79/OYgPDbxn8721zIFeUg+37vWYx2KElrM/taTC
 3BSXd5tnJtPj3Mz3J2j/SKaEr3yzqrEjy2GiWPAWOzo2noO3YXG0CpIS2So=
Subject: [cocci] Checking another deletion of redundant null pointer checks
 (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2752
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/90822099-5434-4421-a611-785511926ecb%40web.de>

Hello,

I accidentally noticed an update candidate.

c4iw_rdev_open():
https://elixir.bootlin.com/linux/v6.15.1/source/drivers/infiniband/hw/cxgb=
4/device.c#L908-L909

I got into the mood to construct another script variant for the semantic p=
atch language.

@deletion@
expression e;
@@
 if (...
-    && e
    )
    kfree(e);


A corresponding patch can be generated accordingly.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time /usr/bin=
/spatch --no-loops =E2=80=A6/Projekte/Coccinelle/janitor/delete_redundant_=
checks4.cocci drivers/infiniband/hw/cxgb4/device.c
=E2=80=A6
@@ -905,7 +905,7 @@ static int c4iw_rdev_open(struct c4iw_rd
=20
        return 0;
 err_free_status_page_and_wr_log:
-       if (c4iw_wr_log && rdev->wr_log)
+       if (c4iw_wr_log)
                kfree(rdev->wr_log);
        free_page((unsigned long)rdev->status_page);
 destroy_ocqp_pool:

real    0m0,454s
user    0m0,413s
sys     0m0,038s


I tried another program call out.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> git checkout =
next-20250606 && time /usr/bin/spatch --no-loops --timeout 45 -j4 --chunks=
ize 1 -dir . =E2=80=A6/Projekte/Coccinelle/janitor/delete_redundant_checks=
4.cocci > =E2=80=A6/Projekte/Bau/Linux/scripts/Coccinelle/deletions1/next/=
20250606/delete_redundant_checks4.diff 2> =E2=80=A6/Projekte/Bau/Linux/scr=
ipts/Coccinelle/deletions1/next/20250606/delete_redundant_checks4-errors.t=
xt
=E2=80=A6
real    5m42,692s
user    20m26,077s
sys     0m13,532s


Now I wonder why the known generated patch was not written into the specif=
ied
diff file for this command variant.
How will the desired data output become consistent (after the software
combination =E2=80=9CCoccinelle 1.3.0=E2=80=9D) for such an use case?

Regards,
Markus
