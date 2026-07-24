Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061E5C531F9
	for <cocci@archiver.kernel.org>; Sat, 25 Jul 2026 11:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:references:in-reply-to:from:date:message-id:
   to:cc:content-transfer-encoding:subject:reply-to:sender:
   list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=KNWwh9ggePXAg2gp21+rSSfMTKdKzjfj/8iPBUjyxVs=;
  b=L/7bhoCzC3HQ2ZyKY0hCVs0vAU4QXxVe2hhITlxbojFDX1M8CIx8DtTI
   sKLDOtwc/MStAj0Sq4lJ5tVl1UFsgEVhLZh240Hp24DqsH1lRWV32hLz/
   UgRMQHIP+GyLN8K9qMOLQ1msJTXrc+iina11CaCnSq9VrZG13ATlRIQ6k
   k=;
X-CSE-ConnectionGUID: E08Iq2zASNqI4OUiXuzYIg==
X-CSE-MsgGUID: 756V6FwcQfOLVfBp7aRxDg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,184,1779141600"; 
   d="scan'208";a="287871610"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jul 2026 13:44:38 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8D2F8802B7; Sat, 25 Jul 2026 13:44:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 9A36F81A5B
	for <cocci@sympa.inria.fr>; Fri, 24 Jul 2026 18:22:00 +0200 (CEST)
X-CSE-ConnectionGUID: C2Py8Vw/Qx+m9OGK91o8Eg==
X-CSE-MsgGUID: rhQ3+deTQ7O0+VS96iBKHA==
IronPort-SDR: 6a639127_UT7Rogq0q4PUFzJi4jvGlFmcJF/YPjoXh85TpxOF7nS+kZn
 wXGcb9jzDto5eTeNjfU2wKi9dHBKGCkhmHetLdw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EtAwAWkGNqgbSAVdFahRpagQ40BAtJhFiPUl0GgT4Di?=
 =?us-ascii?q?S6CGTACkE2BaYErPQIPAQMBDVEEAQEBAgSEfgKNYAIeBwEENBMBAgQDAgMBA?=
 =?us-ascii?q?QEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOO4ZPDYJiAYEkY?=
 =?us-ascii?q?QIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAixfA?=
 =?us-ascii?q?QEBAxIRBBkBGx0BAwwGBQsNAgImAgIgAQERAQUBHAYTIoUDAQYQAQM3A7ZOg?=
 =?us-ascii?q?QJCiz1/FgUCFoEBgg0G2mgKGSgNdYFmAgcUAQGBCS6EeCpdA4I6BBwBBW59h?=
 =?us-ascii?q?AeEAnongRiBEIFKgnY+gh+CCxkVg0aCagSBDoEUgQyMUIU/JgEHAQYXAwcHC?=
 =?us-ascii?q?QUECRMGBQMCAj8JBgUKEgMEAwQEAQILEwkDAwIOAggDAggGGQE/EgQTAggJB?=
 =?us-ascii?q?AsHBR8KAgwUCigiBA4rCgECAVUQBhoBCAYCAgQEAgQCCgIJAgIFAwQCBA0DB?=
 =?us-ascii?q?AEBCAICAyoDAQMZCAkIAgsFERgMCwcxAxAJAwIdAxQWBQgRNAgGFgEaBwUGC?=
 =?us-ascii?q?wEgFhQBBQwRAQIbAiEEHQEQCAMBBwMOBAQCAQsDAQMBFQQICQQMAg8BChIVA?=
 =?us-ascii?q?wMLAwcPAg0HFAUVCwMCDgIJCAwXAgICBgIDAwMKAQIBAQEBAQEBAgcDAwMCA?=
 =?us-ascii?q?xkHBgMDAQEDAQQEAwMCAwUBAwMDBQICCgYJAQEBAQMCAggDBwMKCQIFAxsDH?=
 =?us-ascii?q?AYBAgIDAgECAwYDBwgDCAUDBAIDAwMEAQICAQEBAgMBAwMEAwEDAwIBAwcCA?=
 =?us-ascii?q?gMDAwsBAgMDAwUDBQEFAwUCAgMFBQMFAgIKAgMDAwIBAwIcAwgDBgMSARADA?=
 =?us-ascii?q?wYBAwcDBwIEAwgEAwYCAwgDAwIJCAMWBgMDAwMFAQICAgMFAwMDCAgEAwMEA?=
 =?us-ascii?q?gIDDAIGAwMDAgMDBQMDBwIEAgMGAwMDAQMDBQECBwIDBwIBCwsIAwIEAgkHC?=
 =?us-ascii?q?QcBAgMLBAIEBgQNCQQCBAICDwQEBQMDBwEBAgECCAUGAwICEQUICgUGAgICH?=
 =?us-ascii?q?QMhAQIBDwYBCQUCAQUOBwUCAgoSAwYBAQMEBQUBAwEKAQsBAQIDAwEEBQMDB?=
 =?us-ascii?q?QcBAgQCBwMDAwQDAwMDAQECAgQGBAMCAwcDAwMDAwQFBQUDAgUCBAMFAwcCA?=
 =?us-ascii?q?wMCAQUKAQQFBAoBAwMDAwUFAwICAwMEAQIEBgMEAgMBAggEBgUDAwMFAgMDA?=
 =?us-ascii?q?gICAwMFAQUCAwMDBAMDAwgHBQMDBQIJAwMJAwMLAgIDIQIFAwMDAwYDBwMDB?=
 =?us-ascii?q?AMDAwcHAgMCAwcDAgUCBwUDAwUDBgEDAgEDAwgLGAMLCQgTPQELBy4EBAwqA?=
 =?us-ascii?q?RQUBSkhXxCNbCOCOQcBehOBH2QmgVEBAQGSEBiDFY8RoCFJHgkBBgJggWeBC?=
 =?us-ascii?q?hUKL4p7kGSGFjOqbC6YWpITkVeFSBEkEoFJI4FcMxojgQFtgUlQAxkPjl+DR?=
 =?us-ascii?q?M5JODICPAEHAgcBDASBc4Rei1aBTAEB?=
IronPort-PHdr: A9a23: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
 kthZm+sr115gL5pdGQtgwjZ68InJA==
IronPort-Data: A9a23:hsPSZ60aWS54zmADM/bD5SZ1kn2cJEfYwER7XKvMYLTBsI5bpzQPz
 mVJDDzXbv2DZWr9eIxzaI3k/RgE65/Um9ViQAM/qSg9HnlHgPSZOdnIdU2Y0wG6fpSSFho/h
 yk9QoCdd55sFie0SjOFaOWJQaxUjPnQLlbEILeafHg3GUk8EXlJZStLw4YRmpRvjcWyHzSDs
 Nbzp9y3EFK+0laYCEpNg064gE0p5qmaVA8w5ARkO6gU5gOHzxH5MbpGTU2PByugKmVrNrXiL
 wrz5OnR1n/U+R4rFuSknt7TGmUWQqTfNBS5kXFfXa6vmHBq/kTeBY5mXBa0QR4/ZwShx7id+
 v0U3XCDYV5B0pn3pQgoe0Uw/xdWbfQXouefSZSImZf7I0XuKxMAyhj1Za08FdVwFu1fWAmi+
 RGEQdykg9/qa++emdqGpudQassLB5PTLdMhpTZZ3XLcXNEJYsGaRPXn6ooNtNswrpgm8ff2Y
 sMYbX9+c02FbUQfYhEYD5UxmOrujX76G9FagAjN9Oxnvi6Kllw3iei1WDbWUoTiqcF9k0WWq
 H+cpzyhU0EyO9mWyD7D+XWp7gPKtXmrB9JLTOHmqpaGhnWJxlVISxEbaWLkhqH6tHXvBdN1C
 Gw9r39GQa8arxHyFoasAXVUukWstRkXUNt4CPw/8AjLy6zO4g/fCHJsc9JaQNkvtctzVCNzk
 1HQz4uvCjtov7mYD3ma8994sA9eJwA+d1cTNREbCjIVoNyyh64Q30vIHvtsRfvdYsLOJd3m/
 9ydQMEDa1g7iMcK0+Cq4gmCjWv8/t7GSQk64giRVWWghu+YWGJHT931gbQ4xa8fRGp8crVnl
 CZd8yR5xL5UZaxhbATXHI0w8EiBvp5pygEwfmKD77F6qm31pC/9FWyhyD55I0htP44FfzSvC
 HLuVfdqzMYLZhOCNPcpC6roUphC5fa6SbzNCKuPBvIQOccZSeNy1Hs/DaJm9zu1yBB0+Uz+U
 L/HGfuR4YEyUPw3lWvsHblMjNfGBEkWnAvueHwy9Dz/uZL2WZJfYe5t3IKmN7hksPG3s0/O/
 sxBNsCH7RxaXaesKmPU6IMfZxRCZ3QyGZm8+YQde/+hMzhWPjgrK8bQ5rc9JK1jvaBezdnT8
 l+HB0R39VvYhF/8EzusVExNUr3UcKhakWMaJg0pZFah5Ggia92g7YAZbJoGQoMk/+1Ck99xF
 vkMRNqcD8REWhD4yiQ6QbDgntYzaibxlQaqOgy7agMeZL9lfRTCofX/Tzvs9Q4PLyu5jtQ/q
 LuezTHmQYIPagBhLcTOYtet8g+Bhmcck+dMQEf4GNlfV0Hy+oxMKSaqrPsID+wTCBfEnB226
 h23BEoGmOzzvIMFytnFqqSapYOPEeElPE57HXHe3ImmJxvh4Wuv7o9RYtmmJQmHejvPx5yjQ
 uFJw9XXEv4Nxg9KurUhNYdb9/s14t+3qoJKyghhIm7wUG2qLbFdOViD49hEs/xc571euDbuY
 Hm1xPthBeyrNv/mQXkrHyh0SsSY1PoRpCve0uRtHmX++x1M3eSmVWd8AkCyrRJzfZVJNLEr+
 +MDgPItyheej0MqO+mWjyoP+GWrKGcBYpodtZobIdHKjzQx+FRwOLneIzDTzJLTUvpALngVJ
 iSwgYzcjY993WvHSWI4TlLW7NpehLMPmRFE90ADLFK3gej4huc78RlS0DYvRCFX80lj/9MoH
 VN0Jmt3CL6r7R4xtPNcXmupJR5NNCeZ9mP11VENsm/TFGusaUDgM0w/PvSr7mkC0mcBYAVew
 q6U+FzlXRnuYsv1+Ck4Amxhiv77SO1O5h/wo9+mE+uFDqsFT2Lc2IH2XlUxqjzjHc8Vr2/Er
 7Mz/O9PNIvKBRRJqKg/U4SnxbAcTS6fH1N7QNZjwbgoGF/NczTjyBmMLEGMIvl2HcLoynPhK
 cJSJZNobS+chQKutTEQAJAeL4BkxMAJ4MUwQZK1BGoknYbGkB9XnsPxzAbcilUvYe1SqucmC
 4aIdzu9Am2a3nRVvGnWrfh7AGmzYPhaRQjCxtKwwrwsFbsclc1vLXgd3qeFgHGOFA5B4Rivn
 RjiYpXOxLdI0rVcnIrLE4d/NjrpL/fOVOCCqly8iNFwc9nOE5bqnCEEpmb3Oz95OeMqZO12s
 rCWofjL01jjvr1rd0z4wby6CLtsyfu+eMF1I/DHBiBWsgXaUfC9/iZZ3X6zLKJ4te905+6lY
 lCdQ9Sxf9tEYOVt7iRZRAYGGilMFpmtSLnroB68iPG+ChI99wjjB/H//F/LaVBrTAM5C6fcO
 CTV5cn3vst5qb5SDiAqH/tlWp90AGHyUJscKuHei2OqMXmKsHij5J3ZihsS2RPaACKlEeH7w
 67/aDrQSRCQgJzMnfZl69FcnxtOAHhE1Lx6OgpX/tNtkDm1AVIXNelXY91MFphQlTe0z53iI
 i3EaGw5EyjmQDBYalPG7c/+WhuETPk7UjsjyufFI2vPA8t3OG+BPFel3iJp4nMzayS6ie/+e
 YlY9Xr3MRy8hJpuQI7/IxB9bfhPnpvnKrAgoCgRUPAexz4RBLwL0DpqGw8luenvDZTWjEuST
 YQqbTksfax4IHId1e5vfndUHFcSuzaHI/DEq8uQ6I63hrh3B9GsBBEy1y8fH1HDgAk3yGYye
 E7K
IronPort-HdrOrdr: A9a23:G712I6696diZ5cE3kwPXwNvXdLJyesId70hD6qkRc202TiX8ra
 uTdZsgpHvJYVoqOU3I+urwW5VoP0mskKKdiLN5Vd3OYOCBgguVxepZgrcKrQeNJ8SHzIBg6Z
 s=
X-Talos-CUID: 9a23:KPQNvGzrNt7FcPFR50YVBgU/QPg0IkPCi07AYErpLklKGeSSGXKfrfY=
X-Talos-MUID: 9a23:43u4ewvqcJw1kp+Tf82nnjFbb4Rk7piXV2dV0qs96peFHw9QEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287810464"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFHDwfU5ERJx2XnKCBzgr8WggTRsTQaayFL5Z?=
 =?us-ascii?q?vhF/OrJkk095pw/IgBWt+0lMVyxod6UYwtfKI5B9K3OXsTLCL0INsjDE?=
 =?us-ascii?q?MRTryaXAp9z7GJfIhUxM+qeBRE2EMjiMDDFLGAcUwxx6sjQy/HgbDnca?=
 =?us-ascii?q?OM7OHdKiVl6uFhXIac60P6nA=3D=3D?=
Received: from mail-yw1-f180.google.com ([209.85.128.180])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:21:59 +0200
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81dfdbd86d1so6021757b3.1
        for <cocci@inria.fr>; Fri, 24 Jul 2026 09:21:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784910119; cv=none;
        d=google.com; s=arc-20260327;
        b=iHMtoKxnxvsqFDCYnuuKzkx4ZhiD5EXs0CwiK+GPc26mqcpTkLXdsY1OdCuF1J+Wg4
         HxhE7AljyPEAJCvbuDQwG8kpuHrCpf+L4g2uNfhAyJGtUCIG0x57BhhHRJU7kNkfW1nl
         QdBcWqZ/59A4O+p3tpETUWP08VdKjkAKkBLGyOfGy1sjfPi4AOcyb53R90DyVbt+IC3N
         OzxJvIFDVUQsQQrNRntmB9WLm6LeNk7537/9iQ9m4+MRFUCUA927+cTKgQVxlry7FYns
         JRtKtNNAxoV7OGoRu92ccekwTpebeoH02a8TNGGUJQePSa8LwjvACaU+xU1te1QiCHow
         TVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KNWwh9ggePXAg2gp21+rSSfMTKdKzjfj/8iPBUjyxVs=;
        fh=IEuz3xLeY5CQs2kwWGSMsGHeohYgmgEk2DoDqmW6EAM=;
        b=c8r9hGrSbaNa22nhibmwauOp7mYszwntfBxhNtNMiwmirbBVv2b2iYdcfkJzNY7g9O
         b7y6A5TXl34oWPA4JRs66w3hHTvAlJydZ42XyYY6bxmUEUOojyN5lcpXnAentEQH6Qsu
         uGkQUO52SreshGcrtZQnK8L/uSXEj9bgXNmJxzRL+wxKwAuihCcTjvr2+5CsCIdNgaVt
         ZaP5/O9JCAUqMUGJtMtFjURkoMZZIypeViXy6OBwhw5/gGx/vi8h8+Tmw7qgPX/E/4RD
         +BnqGiO3lV0KmL+7kuxxx6K2oxD/VVl77EV2QydHw5YPVcHEYBJYTveBNM+R1YH79CEW
         2iRQ==;
        darn=inria.fr
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784910119; x=1785514919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNWwh9ggePXAg2gp21+rSSfMTKdKzjfj/8iPBUjyxVs=;
        b=KY4r/9tFkKN4MAsF3gLE+f7XFZ7NejpFL7Gh564xzsDOjBYmCND1g+p3tGANqgAb9j
         GMPZncbtuwYF5tyMrhz1fs6UytwNacXCyWFWRVv41qVgjVLO3zRrWHjgSKkrPeF4oll3
         8K4SUBw9Qm0bpcxiFnJzmHnMMKIyRDHHIGl5Jikxkijuh2eWsf0rbN/OlcZ8sMWTRk8z
         VsyPSRNC9y/w63HJSfHsL7ZzPscrLC1y8KsZA2JrFk9xF0sa+C6W6KkfS046EXZF5Kzp
         nNh2LLNceZnWV87JY6OZd8WYv7PzD2ElpQrHRW8akgl612KCWsZ1mRMDiY1qQ7TjaRAG
         rG+Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro3e/ENI+0Qpm25dmXuethh4FtzbVgH6Y1Fw4ZenqdJ4L6FCAowezRhP6zIOaXKiRE6zBOUFA==@inria.fr
X-Gm-Message-State: AOJu0YwtwmGsEn2dEA622EHKI7zVQ/JparAlLaGuX+9cGltWSVHJ1ULC
	BvJ+0gJUwG2t0qiGqufzoBMUMxAKcyyVZeRHMFmNU7YZUHvtoC3saaE14k1ehdkp7CQhwNlEvOL
	rGxzG/KmSAbLTwx6N5me6JIaKX72aJ1Y=
X-Gm-Gg: AR+sD11WOhPvzZ4YOkaj6bUmJTL+8akqWhhQozKEioN9jC1zpnWrVvcmHXcYq8WKPyS
	Zy3Usl0rWPmd4kBOjOX9UQtFo387cEDalBoKZ/qLy3jjziv0j6rqt+4lplfVih5kqHYxD91nk1T
	YTAYGRcU5RFHhVRmaJvSb+mnQU8Hl2p1DCtlRtD6b3/o2PoBXiO3TEmWhXxNyV9IqbOsDbkK0sZ
	q6WxabvlRQs0FS5GvoG/7Zk4d0B6q3DI3hSLOJpEQLTiT+qTOZBEGIlZY4=
X-Received: by 2002:a05:690c:6a0c:b0:81e:c436:c530 with SMTP id
 00721157ae682-81f4c1481afmr27727447b3.14.1784910118826; Fri, 24 Jul 2026
 09:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-26-ekffu200098@gmail.com> <339532bc-e6e1-4b40-af18-49153c25ad64@linux.intel.com>
In-Reply-To: <339532bc-e6e1-4b40-af18-49153c25ad64@linux.intel.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sat, 25 Jul 2026 01:21:47 +0900
X-Gm-Features: AUfX_myXe4wcCuL-dtwlwTyzUYkGeItepf6TULe2YNMvpUprdsdtWpgiclKHka0
Message-ID: <CABFDxMGQ7CfSy+xOD1QnjHyBm99z659g5KQgFX0=4eTd7hW_Ww@mail.gmail.com>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Julia.Lawall@inria.fr, Azael Avalos <coproscefalo@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH 25/36] platform/x86: toshiba_haps: remove
 conditional return with no effect
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3651
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/JqrBg7FdDWGqjTC-Q_hKmw>

Hello,

On Sat, Jul 25, 2026 at 12:44=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Fri, 24 Jul 2026, Sang-Heon Jeon wrote:
>
> > Both branches of the check return the same value, so the check has
> > no effect. Remove it and return the value directly.
> >
> > This is the result of running the Coccinelle script from
> > scripts/coccinelle/misc/cond_return_no_effect.cocci.
> >
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> >  drivers/platform/x86/toshiba_haps.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/platform/x86/toshiba_haps.c b/drivers/platform/x86=
/toshiba_haps.c
> > index c6633b74029f..4f62476b8dd1 100644
> > --- a/drivers/platform/x86/toshiba_haps.c
> > +++ b/drivers/platform/x86/toshiba_haps.c
> > @@ -251,11 +251,7 @@ static int toshiba_haps_resume(struct device *devi=
ce)
> >                                           haps->protection_level);
> >
> >       /* Reset the protection on resume */
> > -     ret =3D toshiba_haps_reset_protection(haps->acpi_dev->handle);
> > -     if (ret !=3D 0)
> > -             return ret;
> > -
> > -     return ret;
> > +     return toshiba_haps_reset_protection(haps->acpi_dev->handle);
> >  }
> >  #endif
>
> Sadly this has not seen much testing:
>
>   CC      drivers/platform/x86/toshiba_haps.o
> drivers/platform/x86/toshiba_haps.c: In function =E2=80=98toshiba_haps_re=
sume=E2=80=99:
> drivers/platform/x86/toshiba_haps.c:247:13: error: variable =E2=80=98ret=
=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable]
>   247 |         int ret;
>       |             ^~~
> cc1: all warnings being treated as errors
> make[5]: *** [scripts/Makefile.build:289:
> drivers/platform/x86/toshiba_haps.o] Error 1
>
> ...I guess you never took the time to look at and understand the
> surrounding code either. :-(

Right, the assignment of toshiba_haps_protection_level() return value
is unnecessary, whether or not this cleanup is applied. I didn't
expect a case like this, so I didn't look at it carefully enough and
missed it. I'll fix it in v2. Sorry for the noise.

> --
>  i.

Best Regards,
Sang-Heon Jeon
