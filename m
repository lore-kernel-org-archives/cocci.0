Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A187BD5A6E4
	for <cocci@archiver.kernel.org>; Tue, 26 Nov 2024 06:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:date:message-id:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=61+xHfpBwIOVw/PldnRONLFR881pqlqYZaK3EGknstg=;
  b=eWUQZImiOt3X0x77WRq3tAcTgYt4GbZnQreHfSiFHNIpNqtXKhIhyS20
   j7PV3ZuonEJVkimCmiYrMY0CFqEbVYZL/u+LrJz7OPT/oDnvAILBeDeY3
   MwLbtu4TpWYk62v4UbxMgVQAXGir96V5ftprZBYHl95Y86xAS+V730hxM
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@broadcom.com
X-IronPort-AV: E=Sophos;i="6.12,185,1728943200"; 
   d="scan'208";a="195772097"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Nov 2024 07:13:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 30F00E013D; Tue, 26 Nov 2024 07:13:12 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7F711E00B6
	for <cocci@sympa.inria.fr>; Tue, 26 Nov 2024 07:13:07 +0100 (CET)
IronPort-SDR: 674566f2_FQ7WNBstmekZLG3+iK8i5wrvO31A24yQqEohIDQkob5gpKJ
 tNo1XmpArh18h9laoAh26qV6FUPL/m1uSEEnlRw==
X-IPAS-Result: =?us-ascii?q?A0FWBAAzZkVnfLTbVdFaHgE8DAILFYFTgkR9WTQEC0iEV?=
 =?us-ascii?q?o9NoXs7Aw8BAwENOQsEAQEDBI9dAh4HAQQzBg4BAgQBAQEBAwIDAQEBAQEBE?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECEAEBIhkHDhIphXsNgluBLFFVAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBFwIIBV44ER0BATglDwImAiMSAQUBV4JggmQDEaMNgQVCiz6BMoEBg?=
 =?us-ascii?q?gwBAQbcH4FkAwYUgQYugw2CXYJiAYFshnmBAYEhD4FVRIETN4JFAS+DHwKCL?=
 =?us-ascii?q?YMOgmmCRIEzg1wliQCHMoM9kEEmCR0DBwcOK0kPBRwDWTIBVRMXCwcFLYFJA?=
 =?us-ascii?q?QIBg0WBNoFRgxFKhQyBA4JKaUs6Ag0CNoIkfYJNhRmCIIJJTIQQhhgdQAMLY?=
 =?us-ascii?q?gs9NxQbTKEXR4NBgRUsgnqiY4IgoEw0B4QdBYFYBgyKJ5VHM6pRhj+SPI4Al?=
 =?us-ascii?q?WWFMhEjgVokLoEuMxojgQEGgjBPAxkPkhvIWigyCzACBwsBAQMJkSOBSwEB?=
IronPort-PHdr: A9a23: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
 RwBzbj/KMIYMYipgiRf
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:14l7W6Adr1WolYblHemW55DYdb4zR+YMi2TDtnoBLyC9F/bzqy
 nApoV46faZskdzZJhCo7C90cu7MBbhHPdOiOF7AV7IZniDhILHFvAE0aLShxPlXwPxn9Qz6U
 6iScRD4R/LYGSSQfyV3OBwKbcd/OU=
X-Talos-CUID: =?us-ascii?q?9a23=3AeGT2HWhHkA6C5pP9CvPDoaxSzDJuWyXE907pDW6?=
 =?us-ascii?q?EK29zUbueWWLN4PJNup87?=
X-Talos-MUID: 9a23:I5kW+QoshkLahvyWTXMezxp9PtpD8ba+M0Yym8gp6pCnNiVeFyjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,185,1728943200"; 
   d="scan'208";a="102621244"
X-MGA-submission: =?us-ascii?q?MDFRMZuqGkor6dLBzIzoCOEWdTeG6VgtGsfOJB?=
 =?us-ascii?q?3WXz6ncUHN1qH9Tjp4BwMZX4ZjM+iYwe4Bd0c1EfdDnQEoRF6JzC4jn/?=
 =?us-ascii?q?5/U4WpgGwyzP3agOugOtGdjCxdqaXOKMqi96dj1h6NC1ITKUrt62upaA?=
 =?us-ascii?q?0yquxFX+4KrANzEiI/mn8oRQ=3D=3D?=
Received: from mail-yb1-f180.google.com ([209.85.219.180])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 07:13:06 +0100
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e382661fb79so4096157276.0
        for <cocci@inria.fr>; Mon, 25 Nov 2024 22:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732601584; x=1733206384; darn=inria.fr;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=61+xHfpBwIOVw/PldnRONLFR881pqlqYZaK3EGknstg=;
        b=Pqyv6KuB3EVvsV2SlRFrTIbG3avMLZPpWQV7nY3GjFWNbcBVmCCicN7ho6FOVGIZFq
         BZtg8OA7Vf6VSj1FHY3OiDyUpwR2ew0kHC+vqWuEN9g/i93MMzUbbX4egn1IlpqYV2NA
         GT+E8lwE4ZWtkHjGgV3ErFyv1fdh8cOH8Wnls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732601584; x=1733206384;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=61+xHfpBwIOVw/PldnRONLFR881pqlqYZaK3EGknstg=;
        b=Bqi48DuRipQt8isEHZG/tUfbF4rvCDqkkHNogIKiJ1UWTmuGFxd6ydV1ADxxZzqc16
         yCqyQFXdB+/lGZf5rg8g45AeDt8kslWKP85P6VivOR+Etv4tEqJMPs+bCxdlP3+qHuqm
         Up+fwTJYby/Rs4KkW8pUehlgTR5TBla5//JsTlH4/tUlTINHnoSo0OLtQIESVCixDP/+
         Ocy97RdI1FHTiAvpc20BrDvuwAjRrKVpc3NiBnI9lKlkrC583I5OeoELAcZkKAd2vGsD
         Egl7osn0kqIAy8KGHcNb8akWYrbC7RlHbyVTNbBAPavo2HXYST4UihtJ3u8fuzo1sbqO
         F/OQ==
X-Gm-Message-State: AOJu0YxH5wkvH4bsfawLc0ZCD+RQ4GYJfDCU731h8TxaE2zWWUvgEa5C
	AMMd+79z4jT0gmnzCOpN+37oQT0EQbjoCgqFzud4Eq4H45rqwoPSx1qT0zebGVhXYVMvtWxueWp
	/Laaa3OVLDGm+CQcSjVlwSvw7G7NqZiP0XQq99NbW3KSSwhGu9Q==
X-Gm-Gg: ASbGncvgrOxlV5xTjgqO/lEZz/GtxqP7L9QgLv4oRIrQPAs7/PoWkQvLTbjPnvY5T5T
	aVi2ZsLZY1bM2bnKdeNAb+mKwEzL90OH/
X-Google-Smtp-Source: AGHT+IHM9wH1OmmPV0dHjZ7cR73d8Hj7GPMqe6MiyRGHROrjbM7cK7EeC/AnV3vPQQY9lFTSnPDLXZ+pLlNmzOOLqAo=
X-Received: by 2002:a05:6902:2311:b0:e2e:46e5:c2ca with SMTP id
 3f1490d57ef6-e38f8b0b6cfmr14315037276.14.1732601584574; Mon, 25 Nov 2024
 22:13:04 -0800 (PST)
MIME-Version: 1.0
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 26 Nov 2024 01:12:53 -0500
Message-ID: <CABQX2QM+cBpVhcBYRae+W4n5a6bVJ=sC+zu9GGj0veiqvU2_4w@mail.gmail.com>
To: cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Subject: [cocci] Replacing type names
Reply-To: Zack Rusin <zack.rusin@broadcom.com>
X-Loop: cocci@inria.fr
X-Sequence: 2127
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/CABQX2QM%2BcBpVhcBYRae%2BW4n5a6bVJ%3DsC%2Bzu9GGj0veiqvU2_4w%40mail.gmail.com>

Hi,

I'm trying to write a  script to snake case all type/function names
but I'm having a hard time matching some types. I think I'm missing
something silly.

My input script is:
https://gist.github.com/zackr/198db11e5e5243adbdc59b9844d8eb6b
which when applied
spatch --sp-file sample.cocci sample_case.c
on the following sample_case.c file:
https://gist.github.com/zackr/97cb903c6e0306b25dcb8fa9f696077c

ends up doing a little silly things like:
-typedef struct SomeDevice {
-    uint32_t sampleVariableUnsigned;
-    int32_t sampleVariableSigned;
-    float floatVariable1;
-} SomeDevice;
+typedef struct some_device {
+    uint32_t sample_variable_unsigned;
+    int32_t sample_variable_signed;
+    float float_variable1;
+}struct some_device {
+    uint32_t sample_variable_unsigned;
+    int32_t sample_variable_signed;
+    float float_variable1;
+}struct some_device {
+    uint32_t sample_variable_unsigned;
+    int32_t sample_variable_signed;
+    float float_variable1;
+}SomeDevice;

I'm guessing t@p somehow matches three times on the typedef structs...

Does anyone have any tips on how to match both types in definitions, i.e.:
struct Type {...}
and
typedef struct Type {...}
declarations i.e. Type var; and parameters/function return i.e. Type
func(Type var);

Plus is there any way to transform arbitrary function names? I'd like
to endup with:
https://gist.github.com/zackr/c37683157f10b2728dfd3576c88e64f7
in a generic way that basically can transform any arbitrary type,
function and identifier name.

z
