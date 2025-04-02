Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4568AC28B20
	for <cocci@archiver.kernel.org>; Wed,  2 Apr 2025 09:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=XdJQRdqlFEsgevDOa1L9dHFh9bV0Z0lrXL+KZ9U7+do=;
  b=MmadOjNzwEqCIgKN0OKpJUvfO+RdH3y//29f4gMBt3/2VQMzV+vhvuhu
   2o49vJYZ++1Q4jQj5pHfMi7ZvRYsxsSW5g0cB0cXimTfNEAIn+PW+h7+L
   0UhOGXtW+9V+uEgNo1WwigbGHwPmEL/otuhRVRUgAeUHaKAB6k6cGZd/T
   w=;
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
X-IronPort-AV: E=Sophos;i="6.14,181,1736809200"; 
   d="scan'208";a="215971992"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Apr 2025 11:55:43 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 50C86E0D1E; Wed,  2 Apr 2025 11:55:42 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 38ECBE007A
	for <cocci@sympa.inria.fr>; Wed,  2 Apr 2025 11:55:39 +0200 (CEST)
IronPort-SDR: 67ed099c_KH9hRtJasfqHnmy4AqikhqyiOhRI3RqsVmWJ8soJ04v7ehW
 eNGE5XIXwIkhyH4HMbX5jwGnh+e3IVF4b4CGoug==
X-IPAS-Result: =?us-ascii?q?A0GmCAC8CO1ngwsR49RagQmBU4JEfVozBAtICIRNj1GBd?=
 =?us-ascii?q?C2EPo8OiHSBVoF+DwEDAQ07BgECBAEBAwSCDIJ0iysCHgcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBOgcOCjGFew2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQINOkYnBBkBAREmATQCJgJzAQGCfgGCLwEDMQcNBq4rf?=
 =?us-ascii?q?zOBAYIMAQEGgmnXcx8sIleBZQMGgRouhW2CSRoBBW2FPoM5gSEPgVVEgTyCS?=
 =?us-ascii?q?weDUASCK4MOgmmCM4NAgQNnmWmEe4Jlf4kFgU0cA1ksAVUTFwsHBYFsA4EPg?=
 =?us-ascii?q?UV7gj1pSToCDQI1ght8giZqBAWDWIQ8hD2FTYIRggSCMIVHgSmEXS1Pg3odQ?=
 =?us-ascii?q?AIBC209NwkLGwY9pCs7g0dINVhhgQCBEzWTGRWDFK9VNAeCOIFmBYFeDIkFg?=
 =?us-ascii?q?SSVNQYTL5dGDgaSfZh+jgWVVoVYgWc6gVwzGiRPgmdPAxkPjjqDYTPKCkE1A?=
 =?us-ascii?q?gE5AgcBCgEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 IT1qa15rJmHdHPM
IronPort-HdrOrdr: A9a23:4F9AYa5UtCHKMMy+3QPXwPHXdLJyesId70hD6qkXc3Nom62j+f
 xG+c536faaskdzZJhNo6HlBECrewKkyXcN2/h3AV76ZniBhILKFvAB0WKB+V3d8kTFn4Yw6U
 4JScND4bbLfD1HZKjBgTVQQ+xL/OW6
X-Talos-CUID: 9a23:WHoGTG0ZGDgXL4QswN+xHLxfO+wKLVzZ5VPqA0a+LmlzZKDOQHyw5/Yx
X-Talos-MUID: 9a23:CE8GUgnepmVN3XTtuxwTdnpaKPlD0ee3NXkygLMZis+BKy1RYCa02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,181,1736809200"; 
   d="scan'208";a="215971984"
X-MGA-submission: =?us-ascii?q?MDG2L45twppZhLMshfL99dRUzbiuWhEvQOK00p?=
 =?us-ascii?q?l8P4WopyU58D+uOa6iMSqS6J0xuKveI9iWh/Hl5007gEeb5LfBgtKDZz?=
 =?us-ascii?q?PQ5FCbq91tDmA9FIHscAKRWiqTFoeeL5gKYt6ZeQhEyMImgme0HsKCTp?=
 =?us-ascii?q?bfKhZYXCZjq+VTTWcGl6fiAA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 11:55:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743587737; x=1744192537; i=markus.elfring@web.de;
	bh=XdJQRdqlFEsgevDOa1L9dHFh9bV0Z0lrXL+KZ9U7+do=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ofocjZ9SI/H6y7+jHQVbnToJ7Wf+f5DQeDBfzKgv4pe1AwK5bcX0d0MAAqtpmrBU
	 H05RAZu36Smp0RRx7LoJvEwVvXGDhNsgzJl9oNO+58VHo4DX8bM/Hj80VwhCGW4ub
	 eKIriqjqGpYpDyfVQCMqPvrsmDyPJ3+7LLdiFEH2EfFqZmh9GtiFCpyWp5C1O352j
	 sRleGYdB36JZTuK8R+4o/UAd8abJ0TdMVL4T2ahNH3yyXSVe3q4XAv9QUl2QFDIdO
	 9LHE33l19ELdA1iwlOv9S3OPTzRObNJ49kxuL/xNVoWewYLxQQvi5rKV280GZ/PcN
	 XSkd+qksJPCUZOvI/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzit-1ti6qu3OrZ-00QUm5; Wed, 02
 Apr 2025 11:55:37 +0200
Message-ID: <897850f2-998c-4bce-a640-01adcee73a0b@web.de>
Date: Wed, 2 Apr 2025 11:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
Cc: Henry Martin <bsdhenrymartin@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pp/+7l1ak5ibNa9N83wieZMKYe+yq1q8IT/JvKfXVNtge4tEnTA
 PUruJ4+349bSFfU/9LhzMCTtGvBsZIZ6vue12gCEnymfitiXX5g35XqF92CGYwGgpX73the
 qkjUw7EiFjUZvNy5FsB8SMyVyLYdB3W+J4101ufOran/zzDf7pNEcbI9Rjg68dn9wlWmJG0
 DDagH6VrMKBM2hP0zUNSw==
UI-OutboundReport: notjunk:1;M01:P0:9tOPFLy79D0=;DZ8nLSe9Z+dgaJ026GDA9uSrQbi
 vcqyfHFOJYQtbWs2vZyu082JWPVia+FflhJooS3QVqo4Io7+ihwuqyMdDiUHlrU9Mju90bwOu
 1qiVo+WLlDBNMnhLDAfHc82o7UkOrzt2TmClL7XC8ZXb+nZRNhD7frQTK0SFrGC0mngYLrRpI
 VXl7V4jfwUpKOw+tDpxdJhxitGNvAnHlJ3cTZD9JSfA0IreoaYI9MEjD2fHNQZKkhnMLhzDxL
 UJ5P+yxhZgznK6hrpISb3Pyw4PAJz9tXSfwOlaB+JR3y4p/HfQZ/5ih6gwTKcLp5YTwohok3i
 o+zxevwPGwUsDZtrv1CmkR7DUKWW60LHintWrS27gX0G9RKwzgBkSCtZz0XvAJ7dNMqZUBBZr
 ypJ4kQR9rGt32Q6BSE+dDNR0KHBrFf6tZ6qmvTVRCqw658pJY3Cy5SvXDYYPI6EG5nPy3uxvz
 sUAOOfeoCp2T9JInQkhaTaQh6juEJNQwXhkhthg7glmyTGGHh08chM8OCiAuqWaKWVky1HNGg
 GdcKBKi0A/SnPihjW6g6ynvUw/peLVTlpWQbT6z+FT+C0NGtkhlldA8YzLJGnO73/577zT3EG
 wo6uQQkIA+BwH+BAo7aeOo/DVzVJ4X49RCxA5cpDFc2gl3MoHmiJVEExtsahnV3Jl9fnqqDY9
 gWQacA36de6m6+DgMzJKMiSvvlMttNU+a4cKwjx0WQSPGvLPWHaxjJ9gPJ6jmaGF3hNx07wiE
 gwBx9R5ePk+AxBP4FkOVdy0AqABmAoSqWbpzXprVWilaOOvNVZvZooO6ZUFhbJZTn5egq360D
 Uv0nOs3YftpuV9qusmM90fy2qSiB1q6xJgUFl62XDnMCjA1i+YxXrw8JIpAq6IeJtji/94jLm
 S4fjrWTjcLR0RACoJRfaDntscW/65tgyQEVMd2DslZ/zUbsj6Vemzr3mbAvBUXliB9W8EuXK7
 8s7IXSrL5iVKSGOa0jxRkM66We2dpuYjFJmtNKBsNZM5qP7t212kWjARI6xGLRiqyZvpFhQnH
 n6314WC2sbhm6OF2guW4vOKIhtHNzuxT67AM1p1/yTL8WTAJ55niC6kumcVmReZqsgmXSP5QK
 pM7t6Vd+HUtW21b6Upowo6R/UAuc0Qj2yi7NcRkZa2LNqe0r5jyMZizzeD+HJSLlf51xlEDqa
 Xt5Lf3yH1c+/3kvOxNsMJZdY+htEFe7/xhZYsiM4iMt2cBSPzbGp/rHfaQlpyZzEgAldPHOAZ
 kMi5zhSL3MaXu0kdNLxEcXLXiNrQ3pZJFd5JZ42NGfA6W9VdHLV6mOb8w3OthVpvHI7P4uVY+
 +hma1gTiCNlTa76vmu4xZvrH9wRWAsCLBZyZLO/2W11IOa1Ee27V9RcWEZ7HHRklDhq9RbFUK
 vugUAQYP9N7uYhE2TAITK9S4pyteG86/Nyio3qZ09Qp1z3c9mAV90QVtP44UDyYpZd3Aqs4U7
 rQnJ0ccNmzUc1QkgUCHyEd+eFLZ6u/FnVS/zuiDRK8qrRDlvrdgnOc2rtkK2bA9t7BEINzg==
Subject: [cocci] Fixing indentation for a generated patch?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2679
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/897850f2-998c-4bce-a640-01adcee73a0b%40web.de>

Hello,

I noticed during a patch review that a specific source code place contains
the opportunity for another bit of simplification.

Example:
avs_component_probe()
https://elixir.bootlin.com/linux/v6.14-rc6/source/sound/soc/intel/avs/pcm.=
c#L924-L929


I constructed a script variant (like the following) for the semantic patch=
 language.


@replacement disable drop_else, neg_if@
constant char[] text1, text2;
expression action, check, target;
expression list inputs;
@@
-if (check)
-   target =3D action(inputs, text1);
-else
-   target =3D action(inputs, text2);
+target =3D action(inputs, (check) ? text1 : text2);


I find a corresponding test result (from the software combination =E2=80=
=9CCoccinelle 1.3-00083-g4093aad2d=E2=80=9D)
questionable according to known coding style requirements for Linux develo=
pment.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> time spatch =
=E2=80=A6/Projekte/Coccinelle/janitor/use_ternary_operator7.cocci sound/so=
c/intel/avs/pcm.c
=E2=80=A6
@@ -921,12 +921,8 @@ static int avs_component_probe(struct sn
=E2=80=A6
+               mach->tplg_filename =3D devm_kasprintf(adev->dev, GFP_KERN=
EL,
+                                                    (((vendor_id >> 16) &=
 0xFFFF) =3D=3D 0x8086) ? "hda-8086-generic-tplg.bin" : "hda-generic-tplg.=
bin");

                filename =3D kasprintf(GFP_KERNEL, "%s/%s", component->dri=
ver->topology_name_prefix,
                                     mach->tplg_filename);

real    0m0,513s
user    0m0,454s
sys     0m0,057s


How can more appropriate indentation (including tab characters) be achieve=
d
here automatically?

Regards,
Markus
