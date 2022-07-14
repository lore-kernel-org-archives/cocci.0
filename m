Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8F6C433EF
	for <cocci@archiver.kernel.org>; Thu, 14 Jul 2022 09:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=g+sgSgsjcL1YFKwIi2BrfTJvXpG4ktXNCXqR6PrHZX0=;
  b=HSKJSv//Hjp/+ElR3AxXk7n8xlKniZN+uQUJyGj4iAp/V1EGMpIKaUqs
   1K+ssFq6hvCxg2QuNUyY8EJZ5HhKnBMEyGODDFVHrXPVcbTN77yUVW1n3
   XpJ0wAeq63UZCUr+iCSFVoNO8vmihlOwsiPIiKQjKe9MSK6KUOKYUiD5k
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.92,269,1650924000"; 
   d="scan'208";a="45582955"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jul 2022 11:36:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1E7D9E02D7; Thu, 14 Jul 2022 11:36:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8360EE0261
	for <cocci@sympa.inria.fr>; Thu, 14 Jul 2022 11:36:30 +0200 (CEST)
IronPort-SDR: rIMPgrVSexUtmZ4ns3bZs1Wc81AZIhrDFZzxxgYy4kcsj/XH+djpfeoP+jqMGzvanpDTjkszDG
 lnbvi2gJPreiKxu6D2Wo3p6m9Bvj86J2JtjpwCPcmzvrHVvc7gS7f+gZKF9BjjaZ6ND1s4tfLj
 jGRRbHkm1xk7+UDe0kKnYBQRMcwir83DRJCi4AaosN3Imld36HdSXbwjzIkPpWkyCU0X3cnQDb
 1jW3U8X+1puCChuwm3ZK9VmlHm02BlxBwZKat3IAsek1/0H03MEfkO4gzTCb/P3ULyXpBZCrqY
 JMBtMrRXc2NZzdMDj7Hv95x/
X-IPAS-Result: =?us-ascii?q?A0AaBQAo489ifzTQVdFaglgCgiKBVy4EUI1NhWiNWnoMh?=
 =?us-ascii?q?haKJ4F8CwEDAQwBQAIEAQGBUYMvA4USAh0HAQQwCQ4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBAETAQENCwkHCAoHDg4FYAFhAwFEgU+BTyULAzENQ?=
 =?us-ascii?q?BYBgV4pAYN8LgEbHgMSEEsTEQEFASI1hUABAzADBJ8+gQRCjEcFF4EBggkGh?=
 =?us-ascii?q?E0KGSgNajqBHwIHCQEIEoEZAY8mHIINgUuCRIttBJstBA4LDwMDAiIDGi0jA?=
 =?us-ascii?q?QEKAgYGBAYDAQEFAwkCBAISAgIEBxcKEggUAwIGAh0FAQcFAwMSBgwRAQgGB?=
 =?us-ascii?q?gEEAgoBAgIFBQwDAREDAgYCBAQEGBQEAgQHBgIJCQcFFgsECgIWARUCBgwFA?=
 =?us-ascii?q?wICAgICBBIHAQ0FAgIEBwcCBwYDAgkCAwUHAwEEBwwEDA4BAwEHAQQFAwsEA?=
 =?us-ascii?q?QEGAgkDBQgCAQIDCQEBBwQIAQECAgMCAQQCBwECBQMCAwgDAgMDAgEBBA0HA?=
 =?us-ascii?q?wQCAwEFAQUDAgUBAwMCAQMDAgEEAwYJCgQIAQQEAQEBDwIFBwIGAwMCAgICB?=
 =?us-ascii?q?QECDAIBAgQDBgYCAxABAgQBCgEFAgMIAgcDAgYECgQCBwICBAEFAw0BAwUCA?=
 =?us-ascii?q?wEBAwMCBAECAQEDCAEDAgMDAgICAgUCAwICAgkDBAEHAwIBAwEEAwECCgQEA?=
 =?us-ascii?q?wQCAgcCBwIEBwIBAgYDBQYCAgEHAQEECgQDAwMBAwIFAgIDAgYSBgYCBAEDB?=
 =?us-ascii?q?AIKAgILAgcBAQIBAQEBAgMCBwUMAQEBAwIDBgIFAgIBAQMICAMCAQQBBQMBB?=
 =?us-ascii?q?AUDBwIBBQYCCQMDCQMBAQUBAwEJAwMDAgkDAQIMBAMIAwMCAwQCAgICAQMCB?=
 =?us-ascii?q?wUIBAEECQICAgECAgYCAQMaAQIDBQICCQsBBAICAwEDAQECCAQJBAIDBAIBA?=
 =?us-ascii?q?QMCAQICAQUCDgYBAQEBAgMDAQIDAQYHAggCMxEBAwMDAgIFAgIBAgMCAgwBA?=
 =?us-ascii?q?QQCAQIBAgYBAwECAgMBAwECAgMCBgkCBAEFAwMCAgMBAQUPBQIEAgECBgUCA?=
 =?us-ascii?q?QEBBAEDBAQGAgIBAwMCDgIEAQQBAgEBIwMEAgMBAxcBAgECAwMDBAYHBQIBA?=
 =?us-ascii?q?hMBAgEBAQUBAgEBBAIEBAcKAwICBAMDBQEBAgMCAQEBBwwCAgITAhMDAQYBD?=
 =?us-ascii?q?gUUAwEBBAICAQICCgMBAgIBAwIJAgECAQUgAwEBDyQBAQICAgIDBAcCAQQGA?=
 =?us-ascii?q?w0CAgEBAQUGDQMCAwgNAgcDAgEDBQMCAgQBAgQMCQECAgECBAUFAwIBCAYFD?=
 =?us-ascii?q?QUJCwEBAgEDBwQDEQIFAwUFAwMCAQkBBQIDAQIBAQMEAQMEBgEBAgMCAgEGA?=
 =?us-ascii?q?gIBAQMDBAMBAgYCAgcCAwIBBAIDAwEBAQQCAgICAgMDCAMCAQgHBQEGAQIBB?=
 =?us-ascii?q?AMCAgECBwEEAQkCAQMDBQMEAQoDDwMFAwEDAwIVCgUBBQgGCQIEBQIFAwIEA?=
 =?us-ascii?q?gMDAgIIAwIEAwILAwIGAwQCBxMHAgMCAgUCAgICAgUEAwECAgICAgIFAgQCA?=
 =?us-ascii?q?QUBAgICAQICAgQBAgIHBAIDAQMEDgMDBAICBwECAgEGAQIHAwECAQQDAQEEA?=
 =?us-ascii?q?gIEAQICBQICAQQBAwECBgIEAwoCAgMCAgIGCAMDDAkCAwUCAgUBAQIHBAICC?=
 =?us-ascii?q?wEGAgcCAgECAxEBAwIBBAUFAwMDCQICAwIEAgIMAQEBAwICAQUFAgQHDQICA?=
 =?us-ascii?q?gIEAgICAQIDAgIBAQICBAQJEgEBAgMGAwQGAwUDAgoYAQYCAgEBAgICAwMCB?=
 =?us-ascii?q?gIBAggCBQEEBQIBAgICAgQBAwYCAwECAQIBAgIDAwMCAQQCBAMDAQECAQICA?=
 =?us-ascii?q?gMCAgIFAgIBFwYnAQYYTJ0oYAgugkqscZR6YYITZwWgRJZWkg+Wd6cgAgoHB?=
 =?us-ascii?q?hAjEoEsghVNIxVsgjdOAQIBAQENAQIBAQMBAgECCQEBApIPimA/NDsCBgsBA?=
 =?us-ascii?q?QMJgjqDCiYTCwGFVIMoAQE?=
IronPort-PHdr: A9a23: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
 w==
IronPort-Data: A9a23:gLT496oPmI6+baeILXUlGbITivFeBmIxYxIvgKrLsJaIsI4StFCzt
 garIBnVaf/fZGX2ftBwat+3oBgB6pPSzdQxSwps+yw3ES4V9+PIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVKicfHoZqTZMEE/Nszo68wICqtMu0ILR7z+l4
 4uo+ZWAYQP9glaYD0pNg069gEM31BjNkGhA1rAOTagjUIj2yhH5pLpGTU2AByOQrrt8RoZWd
 M6fpF2NxV41yj92Yj+TfhkXRWVRKlLaFVDmZnO7wMFOiDAazsA5+v5T2Pbx9S67hh3R9+2dx
 umhurSWGFgLJYHDud8RUjNlFCxOOIdsx4T+dC3XXcy7lyUqclPpyvRqSUw6ZMgWp7wxDmZJ+
 vgVbjsKa3hvhcrsmOP9GrQq3JxzapSxVG8ckikIITXxBOgvW5nJa6rP7N5cmjw3g6iiGN6HN
 pFCMGQwM3wsZTUQGgotOq8Dl9u3vSDhcS1YthWw+Ysotj27IAtZieCxarI5YOeiTsJelUewv
 XPD522/AxcANdXZxyDtz563rurGnCe+VY5LUbPlrLhlh1qcwmFVAxoTPbemnRWnomjvBPBEB
 0M1wSYvh5U1+XyuZPPCZCTt9RZooSUgc9ZXFuQ77iSExazV/xuVCwA4othpOIxOWCgeFWxC6
 7OZoz/6LWcw7+DNGBpx4p/R/GziY3FERYMXTXZcFVNt3jX1nG0kYvvyojtLFae0ipj4FWi1z
 W3Q6ic5gLoXgIgA0KDTEbH7b9CE98Chou0dvF2/soeZAuVROtLNi2uAtwSz0Bq4BNzFJmRtR
 VBd8yRk0MgADIuWiAuGS/gXEbei6p6taWOB3gE0QMF7qW73oxZPmLy8BhkudC+F1e5UKVfUj
 LP75Gu9GbcIYST2N/4vC25PI51yk/C9fTgaahwkRoMWPsIZmP6v8yZpakqdt10BY2B9+ZzTz
 ayzKJ72ZV5DUfoP5GPvG481jOF2rghjmju7bc2ql3yPjOvFDFbIGOdtGAXUMogRsvjfyC2Lq
 IY3Cid/408AOAEISnKHr9B7wJFjBSRTOK0aXOQOKLfbeVc3Rz97YxITqJt4E7FYc21uvr+g1
 hmAtoVwkTITXFXLdleHbG5NcrTqUcotpH43J31+MlOh2nxlaoGqtf9Ne5wydLgh1epi0f8kF
 6lfK5vcWqxCGmbd5jAQTZjht4g9JhmmgAS5OSD6MjUyephXQRPEp43/dQz1+ShSVSe67JNso
 7Cp2g7Bb4AEQgBuUJTfZP61ngG+uHEcnKR5WE6Reotff0Dl8Y5LLS3tj69vc5tcd0mbnjbDj
 lSYGxYVo+XJsrQZytiRiPDWtZqtHst/AlFeQDvW4LOwAi/QoTiuzIpGZ+CXJGyPWW7x/pKiU
 uVb1fTLNvMKwQRRuI1mHrc3lK8z6oe9p7JeyQg4TnzHY07xUeFlK3iCmMRD7+hDm+UftgyxV
 UaCvNJdPOzRas/iFVcQIisjb/iCha5IwGiMtaxtLRWo/jJz8ZqGTV5WY0uGhhtbIeYnK4gi2
 +og5JMb5lDtkBYsKdra3ClY+37WdS4FWqQj85wWWcrl11BtxVZFbpjRTCTx5cjXOdlLN0ArJ
 B6ShbbD1+sAnBucKyJrGCifx/dZiLQPpAtOkA0IKWOPl4eXnfQwxhBQrWk6Qwk9Is+rCA6v1
 rWH9nGZJJliOx9tjclHGm2gQkRPWUff9Uv2xF8E0mbeSiFEk4ALwHIVYY6wEIIxqgqwvQS3O
 JmXzW/kVXDhe8SZMu4aRxt+s/K6JTBu3lSqpS1kdvhp27E1ZDPkhumlYm9gR94Lxy8urBWvm
 NSGN9qcpUE22eD8bkH750SnOWwsdS25
IronPort-HdrOrdr: A9a23:hnE9OKuCWmUHJDSUb/tk4aNZ7skDQdV00zEX/kB9WHVpm62j5r
 uTdZEgvyMc5wxhP03I9erwWpVoIkmsjaKdg7NhRItKNTOO0ADJXeJfBOPZogEIcBeOktK1u5
 0QFpRWNMf9Fhxzg8r8/WCDYrAdKRq8nJxAR92y856gd25XgmhbgTtENg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,269,1650924000"; 
   d="scan'208";a="19331677"
X-MGA-submission: =?us-ascii?q?MDF1Pkofay7VaJeAiEUi6kvgmnVfvI10Mbvgfu?=
 =?us-ascii?q?7goWlCybg5yQfGxTdVyz3VfQdhdJlEDGlz6YGIhRaC5yIUvT8xD7KRWr?=
 =?us-ascii?q?5nqillCIhqvviRDX9iFTB9uCKr9eAwrlIE3goWQewA2Y+9/1E62cNHMA?=
 =?us-ascii?q?4WuuwyXN6+RjS1D/TsIwNKEA=3D=3D?=
Received: from mail-ed1-f52.google.com ([209.85.208.52])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 11:36:29 +0200
Received: by mail-ed1-f52.google.com with SMTP id fd6so1655385edb.5
        for <cocci@inria.fr>; Thu, 14 Jul 2022 02:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:user-agent:message-id:mime-version;
        bh=g+sgSgsjcL1YFKwIi2BrfTJvXpG4ktXNCXqR6PrHZX0=;
        b=fIncfo3F8ZzGXYWNjHna8Hm/YVrhPnjDe+hcRYCRVLW6FOPq01smnyZndmXCf6wC8w
         /qqYdOh1gyPvHqSzP3KeH0wWJJk+cQml0QqftbwzGHJOKnO7glixjfH+/wq8KSrPr/g8
         azYQtjfINI4H+9viPNVC4UCeqNEaVeeWISm1x9tiiVGzl2mNkYSe28/mxdxymQWVSoGU
         BlBvj0iyRXnlbQKhJ3qpFYm8vBmspEUOzRftThd+lcGtAYIaW7h0HHTebou8ZmbqSVU3
         LIJZyP3KzKv0CyFBXZ1nVWQ8oMqdSenwDVyjrz4Zt1kXxQg9+tA6g5izJrs+YAFZWWHK
         a71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:user-agent:message-id
         :mime-version;
        bh=g+sgSgsjcL1YFKwIi2BrfTJvXpG4ktXNCXqR6PrHZX0=;
        b=KYKRzCTf2uZoEmh28cA+GO6Q/ycA/wDKXQaerzpnTJ7VGS9TuBTgCjeQJYGQizcUN6
         5nY9nVCt5ZU9hYUNDce31LNSrIVavaAkvKM5v6oMdMjxaeke7AFtggB/tTi1CQhgdoWw
         cm0dd3Mu1hs8+IG6EhBUrmQghEvECwiR/tInP/0CJSDrOHYo3qe481Fhw2MKgR6lhY4i
         8smBhsCWIoX3o+LlsC5Sh4qOFIEQs20Z7MThmasjAdYySN+A2vGaAp8Bi++68XkldZcl
         20tsVejylXSxoHsf2yU4s9nuYS0WnK8cBUODEztlXoy22DqNKTkUbrYUgT11ubXJGEdn
         BVRg==
X-Gm-Message-State: AJIora8AtVas1ZjRREC4hg7uxo5jKXQnlIBhUvjMiyBP+IR3UxbU1/QM
	SpKbcfc2RHJxBvtRUofXiXr+ThGZAzmkjg==
X-Google-Smtp-Source: AGRyM1uTQ+B37FKwk7jhW+qSCcEqVF8m3OOaaEwQJLkfKqRuG4aSO2HvdSSRBTkDFDPUss/BX2cP/Q==
X-Received: by 2002:a05:6402:1741:b0:433:4e4d:bfb4 with SMTP id v1-20020a056402174100b004334e4dbfb4mr11096429edx.7.1657791388547;
        Thu, 14 Jul 2022 02:36:28 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id h17-20020a50ed91000000b0043a6df72c11sm723445edr.63.2022.07.14.02.36.27
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 02:36:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
	(envelope-from <avarab@gmail.com>)
	id 1oBvGk-002AxJ-PL
	for cocci@inria.fr;
	Thu, 14 Jul 2022 11:36:26 +0200
From: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Coccinelle ML <cocci@inria.fr>
Date: Thu, 14 Jul 2022 11:31:09 +0200
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
Message-ID: <220714.86bkts2fz9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [cocci] How do I disable formatting for the "+"-side of a rule?
Reply-To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 490
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/220714.86bkts2fz9.gmgdl%40evledraar.gmail.com>

How do I stop coccinelle from turning my "{ 0 };\n" into
"{\n\t\t0\n\t};\n"?

I haven't been able to find in the docs how to disable formatting on the
"+"-side of a rule. I have a rule like:
	
	@@
	type T;
	identifier I;
	@@
	- T I;
	+ T I = { 0 };
	... when != \( I \| &I \)
	- memset(&I, 0, ...);

Which produces the expected results as far as the patch is concerned:
	
	diff -u -p a/builtin/for-each-ref.c b/builtin/for-each-ref.c
	--- a/builtin/for-each-ref.c
	+++ b/builtin/for-each-ref.c
	@@ -20,7 +20,9 @@ int cmd_for_each_ref(int argc, const cha
	 	struct ref_sorting *sorting;
	 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
	 	int maxcount = 0, icase = 0;
	-	struct ref_array array;
	+	struct ref_array array = {
	+		0
	+	};
	 	struct ref_filter filter;
	 	struct ref_format format = REF_FORMAT_INIT;
	 	struct strbuf output = STRBUF_INIT;
	@@ -52,7 +54,6 @@ int cmd_for_each_ref(int argc, const cha
	 		OPT_END(),
	 	};
	 
	-	memset(&array, 0, sizeof(array));
	 	memset(&filter, 0, sizeof(filter));
	 
	 	format.format = "%(objectname) %(objecttype)\t%(refname)";
	
But I'd like for that to be e.g.:

	struct ref_array array = { 0 };

Which is a common idiom both in this codebase (git) and elsewhere.

Usually I can find an answer in one of the coccinelle.git's *.cocci
files, the man page, or the grammar PDF, but in this case I've come up
blank...
