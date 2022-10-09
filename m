Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80B0C433F5
	for <cocci@archiver.kernel.org>; Sun,  9 Oct 2022 18:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=i76AD8zPTgyh+QGg4MNmmdW26/iTXDC2CpF5T5kjf4E=;
  b=YAk8WmzSRAjWaeHxj5cF1Y4DaXgxZ7VgZnFjn83XYcmBfLkoLrChc/GW
   bTFUzfEhTMxcX6wANSmSH8/7bmFyZ9qF4KkSmvs0dnAo1eg5FSubo9WtF
   BFd1b63vurFwbn/kArfURNbPpouX63Wj8mvw/Myl9Tbs4O0ObMNJ6UKDd
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@chromium.org
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="56688647"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Oct 2022 20:17:46 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A5342E0121; Sun,  9 Oct 2022 20:17:46 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8F1EEE0121
	for <cocci@sympa.inria.fr>; Sun,  9 Oct 2022 20:16:09 +0200 (CEST)
IronPort-SDR: 63430fe9_q8FoU0ZPp4qrN5YvOTQk070nfK5yUqFlT603H4aDREBP7bn
 EG/rFW3Yg+XeUjMA7r66/6tMIV+uevZkF82CY/Q==
X-IPAS-Result: =?us-ascii?q?A0BxAgADD0Njf6rWVdFagliCJIFXLgRQjUylLxSBaAsBA?=
 =?us-ascii?q?wEMAUIEAQGFBYR2Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBAETAQEYCRkHDg4FJIVoDYI1KQGDZhYgAQ0BATcBgRQBBQEiEyKCW4MhA?=
 =?us-ascii?q?58TgQRCjGSBAYIIAQEGgmCDLoFcCQkBCIErinyEOoEhHIFJRIJRgTd1hCqGN?=
 =?us-ascii?q?SKSJYhHAwkDBwVJQAMLHw0WNhgDFAMFIQcDGQ8jDQ0EHQwDAwUlAwICGwcCA?=
 =?us-ascii?q?gMCBhMFAgI1GDQIBAgEKyQPBQIHLwUELwIeBAUGEQgCFgIGBAQEBBUCEAgCC?=
 =?us-ascii?q?CYXBxMzGQEFWQ4JIRwoDQUGEwMgbwUHOw8oL2krHRsHgQwqKBUDBAQDAgYTA?=
 =?us-ascii?q?yACDSkxFAQpEg8tBylxCQIDImoDAwQoLAMJIR8HKCQ8B1g6BQMCECI9BgMJA?=
 =?us-ascii?q?wIkE0Z2MhIUBQMNGSYIBTcaBAg8AgUGUxMCChIDEg8tSQ9KPj2cGYEOAYJKo?=
 =?us-ascii?q?T+CFopxk3eDaIFJDJ5NTJZohAWOGAEthFSSD6MehCgCCgcGECOBPjqBWzMaC?=
 =?us-ascii?q?CgIgyJOAxkPlyaFaiE0OwIGCwEBAwmLFQEB?=
IronPort-PHdr: A9a23:bH23SxStEvnuQmczi5YM+1B7Ydpson6VAWYlg6HPa5pwe6iut67vI
 FbYra00ygOTBsOAtKsP0rCP+4nbGkU4qa6bt34DdJEeHzQksu4x2zIaPcieFEfgJ+TrZSFpV
 O5LVVti4m3peRMNQJW2aFLduGC94iAPERvjKwV1Ov71GonPhMiryuy+4ZLebxtGiTanb75/L
 gi6oQrMusUInIdpN7o8xAbOrnZUYepd2HlmJUiUnxby58ew+IBs/iFNsP8/9MBOTLv3cb0gQ
 bNXEDopPWY15Nb2tRbYVguA+mEcUmQNnRVWBQXO8Qz3UY3wsiv+sep9xTWaMMjrRr06RTiu8
 6FmQwLzhSwZKzA27n3Yis1ojKJavh2hoQB/w5XJa42RLfZyY7/Rcc8fSWdHQ81fVTFOApmkY
 oUPEeQMI/tWoYf+qVUJohSwChKhCP/sxzJSmnP7x7E23/gnHArb3AIgBdUOsHHModvwKqgdT
 /u1x7TWwDXEaPNW2ir25Y/Lch8/v/6MRq5/cc3WyUksDA7KklWQqZbiPzOQ1+QNrm2b4/BnV
 eK1hG4qsgd8qSWgyckwkIfGnJ4Vykza+iVjxoY4PcC1RVBnbNO4EJVdsyKXOol5T80iTGxlu
 SI3x70btZO4fyUHypAqywDcZvGFc4WE/hPuWeSPLDp6mH9oerOyihi0/EO9yeP8TtG53EhWo
 idBiNXBtXAA2wbN5sSaRfZx5Fqt1DST2wzL9+1JJUM5mbDGJ5MuwrM8jJsevEvZEiPrmUj7g
 qmbfVg+9Oey8eToeLDmq4ecN4BqjgH+NbwjmsmlDuQ5NggCRnCb+eCh2LH68031XbdHguEsn
 qnWt5DaIssbpqqnDANPzokj7BO/Ay+n0NQeg3YHMEpIdAybg4XtIV3DI/D1Ae2hj1ixnzpn3
 e3KM7/9DpnVK3jMirbhfbJz605GzwozyMhS55FKBb4fO/L8RkjxtNvbDhIiLwO0w/znCNJ41
 oMfRGKPB7WVMKTIsV+H/u4vJfKDa5cPuDnhM/gl++LujXghlFMAZaWpx4cYaGikHvR6JEWUe
 WbjgtAdHmgWvwozV/fqiV2HUT5LfXm+RaM85jchCIKnF4jPXI6tgKbSlBu8S79LYmFPQnSFD
 n7sc83QWeoIaSvUJsZ+mzgAfbmnUY4okx+04lzU0b1ie8nZ9zZQnpXk15Ah5ODejho18j9cB
 MSH1GSMUmQymXkHEWxllJtjqFBwnw/QmZNzhOZVQJkKv6shumYSMJfdy7Y/ENXuQkfbedzPT
 l+6Q9KgCDV3T9QrwtZIbVwuU866gEXl2CynS6QQi6TNHIY9p6HR0mP6IMF+433Gzq4kjkQjB
 MxVOj7unbZxojDaHJWBiECFj+CvfKUY0jTK8TKAwGeVt0ZfUyZ7Ub/CWHECYw3Rt9uqrljaQ
 eqIDrIqehBE1dbEKqZObYjxik5aQf74JNnES2e4mmP1HRLRg73VM9KsdGIa0yHQTkMDlmj/5
 F6gMg4zTmekqmPaVnl1EE73Jlnr+q94oW+6SUk9y0eLaVdg3vy74Exdg/vUUP4V0r8e3UVp4
 zxpAFaw2c7XANuctkJgeqtbe9Y0/FZA0yrQqQV8OpWqK60qiEQZdkx7uEbn1hM/DYsl84Bir
 34n1wF1LqGw21NbcDaZwJW2PafYayHz8B2pd6/KywTGyt/Fn8VHoP88qljloESoDh94qyQhg
 4QTiSLAoMyVVFl3M9q5SEs8+hlkqquPZyA849mRznhwKeyutTSE3ds1BewjwxLmftFFMarCG
 hWhdq9ST8WoNuEunECkKxweO+UHvq05MtitcPyF8KWrJuFlnS+jy2Nd78outyDEvzo5UePO0
 5sflrub0wacXDD7j3+qstrwnIFZYHcVBGX1mk2GTMZBI6Z1e4gME2KnJca6k85/i5DaUHld7
 Fe/BlkC1adFYDKqZkfmlU1V3EUT+zm8nDegiiZzmHcvp7ae2yrHx6LjcgAGMyhFXjsqgVDpK
 Imyx9cUOSrgJwskmQCu4kH576NbvqN6LnTWB0BScGD6InpjXa25qreZK5QXudV47GMNCbj6O
 A/CArfm6wMXySbiA3dTyFVZP3mxt5P1kgY7wGORIXBvrWbILMR5xBPR/tvZFrZa2jsLQjU9i
 CGCXADteYn0u4/Ny9Ga7bjtMgDpHodeeiTq046a4S6y5GkwRAa6g+j2gNrsVw4zzS780dBuE
 yTOthf1JIfxhMHYeapqeFdlAFjk5o90AIZ7x8EziZwL0n8dhb2e/WAAlGbuNJNcw620Px9vD
 XYbhsXY5gTowhgpLX+E3In+UXa1yct7YNy7f2ZQ3TgypZMvau/c/PlPmi17pUC9pATabK1mn
 zsT/vAp7WYTn+ADvAd+hjXYGL0ZGlNUeDD9jxndpc7rt71ZPSz8FNr4nFo7h92qC6uO5x1RS
 GqsMIl3Bjd+t41+KA6eiyC1s9C8PoOMMpRL8UfI2xbY07oLdNRrzaFM3HQ/fzq65CxAqaZzj
 AQyj8/k+tHfcSM1uvr+WEYQNyWpNZ1NvGux3OAOxoDOmNr3VpR5RmdUBt2xEbTxQWhU7bO+Z
 2PsWHU9sivJRuaZRFXCrh8g9zWWTdiqLy3FfSFJi4w9G1/NYhQY2llcXS1mzMdmTUbzlZCnK
 AEhoWlPgzyw4hpUlrAyb0i5AjqZ/V34LG9zEcfXLQIKvFsbuQGIYYrHv7g1R2YBr9WgtFDfc
 DXFIV4TXCdSAArcQAmyW9vmrc/J9+zSbganB93JZ7jG6elXVvPSgImqzpMj5TGHcMOGInhlC
 fQ/nEtFR3FwXcrDyX0JTGQMmiTBYtT+xl/08zBrrs257PXgWR7+rYqJBbxINNxz+hewya6dP
 u+UjSx9JH5WzJQJjXPPzbEe2hYVhUQMP3G1Fq8csCfWUK/KsqpeDhpecycqccURsPp60Q5KN
 srWzNjy0/8wj/I4DUtESU20msytYp9vQSn1P1fGCUCXcbWecGeTkoenPOXmEOEW1boM5HjS8
 X6BHkTuPyqOjWzsXhGra6RXiT2DeQZZs8e7ewpsDm7qSJTnbAe6OZl5l25To/V8i3XUOGobK
 TU5fVlKq+ja7i5Vmf54HG9p5Xp/KuyFhiPf6PPXYMVz07MjEmFvmuRW7W5vgaNS9z1BTedpl
 TH6q9dvpxS+lrDKxGM4CFxBrTFEgI/NtkJnc/a8lNEISTPP+xQD6n+VAhIBqo5+C9HhjKtXz
 8DGiKP5LDoqGz389ssGAM3VNcfBN2AuY0OB8Nv8BwsfSjuqKGSZgFZSwqn6Hpy9q5E7rt30n
 MNLROYEDBo6EfQVDkkjF9sHcs8fYw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:uOR0PqlXbaDYer/8Ol9f1x6hb4TpDfLt3DAbv31ZSRFFG/FwWf
 re+cjzsiWE9Qr5PUtLpTnuAtjmfZqxz+8X3WBzB8bbYOCZghrPEGgK1+KLqF3d8kXFl9K1vp
 0QF5SWZueAb2RSvILW7Ba1FtA4zMLC0qy57N2utUtFfEVGZ75t6gFhBh3eKE15QwFaGYE0fa
 DsnfavZADNRZ3UVKmG77U+MNQr3+e77a4OqCRpOyIa
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,172,1661810400"; 
   d="scan'208";a="56688595"
X-MGA-submission: =?us-ascii?q?MDFOtk26u4ReoH6J2P/ITXSDyA20G6RJfMY17J?=
 =?us-ascii?q?XeFQLqnaML9hLxyh0u9V4ky8f4N6PwLdUNsi0X+vwf2QkXtWhWoqm3CU?=
 =?us-ascii?q?6/hbfWKep20NMuES/d5KiCaF89PMVOBVk/7a/EfEkVUY3dUOi3UtyNhJ?=
 =?us-ascii?q?ufaHYyUhCCYwg/dfj2JCRclQ=3D=3D?=
Received: from mail-pl1-f170.google.com ([209.85.214.170])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2022 20:16:08 +0200
Received: by mail-pl1-f170.google.com with SMTP id n7so8659113plp.1
        for <cocci@inria.fr>; Sun, 09 Oct 2022 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i76AD8zPTgyh+QGg4MNmmdW26/iTXDC2CpF5T5kjf4E=;
        b=X9zr3R54WwqprYUPQMyY46a+6a7mk6kMWuhzlwCkxSzZOtQ/6gy3RGnGLUDJ+vTUhX
         U2t1nYFJcyZoZAWhufOFLI1pC785N3JG3Acc9J6BWlOSZTNF3sTsy0yx1kMgY8mxWDNk
         ea5m1m/+SinK6UJxu2uMV4/brAK5MH4635r04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i76AD8zPTgyh+QGg4MNmmdW26/iTXDC2CpF5T5kjf4E=;
        b=tfr2bissYZnQfbiQEYYUc3FDnr/Ba5TEJlyspCKTXoTqOpBScoz0Lo0zhmW8BRb+Zv
         J5a2Tb0pCjaLSIgY5GlJ3QeXmnW7wEVaAphOEa2cHbDDkqOdcyLzPU7tsoxBC5QwgJdh
         Q1gBBt8s2RvrAq2TvHwzq0p206f055BFXqpiNCrwfiCLgINWcnwcUVPiRQ9NMTgMA6bb
         jTohrDBOW+PVIZCFY07YyyFa4GZg0Af9ipFRQhZkGvSPa0AGkGnOMJrejM76PFvyh2gV
         eIlNjab9SWCu6acYkHZFHszJ3U5+aiOFLy4hbvij9/rvJUdEkMInVc521CoSg0VBQPLE
         LhBg==
X-Gm-Message-State: ACrzQf0YbRZZbUlkfG0ouGGmzm4AWgHg32z22l3Apg/IFRmMiadw8ElQ
	iCPFYI3lyvPoQPHAEesTCGZAAw==
X-Google-Smtp-Source: AMsMyM4We+gyViSAmmeikvUD45XAs3kPSQRQ7R4bA6/hWI2PTNmLYsXczTXbO24k4ni/unNOiGtcFQ==
X-Received: by 2002:a17:90b:1d8c:b0:20d:3180:3e8a with SMTP id pf12-20020a17090b1d8c00b0020d31803e8amr4160915pjb.68.1665339366811;
        Sun, 09 Oct 2022 11:16:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h131-20020a628389000000b00562641bc0b5sm5258639pfe.132.2022.10.09.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 11:16:06 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Kees Cook <keescook@chromium.org>,
	cocci@inria.fr,
	linux-hardening@vger.kernel.org
Date: Sun,  9 Oct 2022 11:16:03 -0700
Message-Id: <20221009181603.3242176-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691; h=from:subject; bh=IfKl0d3b4Wva9kr26WhNzlJvAFNsEln7eoEO6SO+E6Y=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjQw/ixRXa9E0H0DKu0pWbrRZ+/56bjjFqZPIZ0kI7 hSPRY/qJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0MP4gAKCRCJcvTf3G3AJq+AEA CbIe/qtPWgOH5s/FJi2Rz3ZrcLHI6UHuwkcE4TfVT/qVJFE/k3huTtZGueDXFa6zRhTUc8HIJ1DEBw DkA7rL8KJqHNFOTadelPROVwy//NY7j81sLOUQGeBTE3RQeAtrZo9KMfusSx5RGZFTmgFI4qoySgpu f13vmf8ADZLvjdxJ8ch/BUX2YAvPnsukSufUErfjrwKL4+l+6SC6p7/OPAe4HJNw0Kau4FrCxcHFE5 0smMu3BKEkmsI0KdOriw0Z4obFn9/hpp0T5q7/pkJDJlaDRFiBLLxEyp+Y6AraIgQAoEEJOPUaXslg /hbRNRBD7xZMQemT22wd6+CnNK05jjNete6YLB19jSRkPS61Ujf7ZrrR6qnxeOuAoOzOrBHXeBzjgf fFjzk3A5ZD8VewRMr+Cflcj9sBs3Wn7FfjEd1WXNmnO4lcmOIsekKgUERDexmQGpZuxCfaRlxjAVTf PoCUd0szrFurxMjHhT716Jf/D++pH+gOhbRgeKB1mI7TtXcBP2HUTwxUM1dOlZCpMo1U6DG7e1Rc2o Cfo3OrJApbuWa2X0qWznHFVKf+Pf9BZlU6pxh6DwcREStvVGNgn1yn7y8x/RcylbmRX2f0G3V7mC7s IWIQAUeqbLDhf4pAMfwzF+2mZK58qhxJEBw7+TFX0sGO7J6vpEY/I3AyrmXA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH] python: Add make_expr and include_match
 documentation
Reply-To: Kees Cook <keescook@chromium.org>
X-Loop: cocci@inria.fr
X-Sequence: 637
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/20221009181603.3242176-1-keescook%40chromium.org>

Add the 'make_expr' and 'include_match' helpers in the Python
documentation. Additionally cleans up a markdown-breaking line split.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 python/python_documentation.md | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/python/python_documentation.md b/python/python_documentation.md
index d0194d6c1391..1d933b9a3934 100644
--- a/python/python_documentation.md
+++ b/python/python_documentation.md
@@ -11,13 +11,20 @@ file at the end of the execution of the Python script.
 
 Example: tests/exitp.cocci
 
+## cocci.include_match(state)
+
+If a python rule is running, it has matched. If the match should be
+removed from consideration, this can be called with `state` set to
+`False`.
+
+Example: tests/incpos.cocci
+
 ## cocci.has_env_binding(rule, name)
 
 Returns `true` if the meta-variable `name` is bound in the rule
 `rule`.
 
-## cocci.add_pending_instance(files, virtual_rules, virtual_identifiers,
-       extend_virtual_ids)
+## cocci.add_pending_instance(files, virtual_rules, virtual_identifiers, extend_virtual_ids)
 
 Internal function for the method iteration.register().
 
@@ -28,9 +35,17 @@ Converts the string `id` to a C identifier.
 
 Example: tests/python_mdecl.cocci
 
+## cocci.make_expr(expr)
+
+Converts the thing `expr` to a C expression.
+(Equivalent to Coccilib.make_expr in OCaml.)
+
+Example: tests/python_mdecl.cocci
+
 ## cocci.make_stmt(phrase)
 
 Parses the string `phrase` as a C statement and returns the statement.
+(Equivalent to Coccilib.make_stmt in OCaml.)
 
 Example: tests/python_mdecl.cocci
 
-- 
2.34.1

