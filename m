Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FE6F3C27D
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 09:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rBQuohd/vt2LAF3I4JQSmNdjevqrT6nbat4LeA+5Cz4=;
  b=U2nXQpApUmsvh8cFj5Xn4d+GZpBBkNH2KvzNSNK5o2n2nT55dYyv0oNR
   0b47d2DtwRYAF/iw8J3vvYIvGyqz4i7D8MrC65j5j3ukmb4fUhplScQcF
   jr3CDj+g2LzY55/c8NlGtxlTh7g7yeAYw5FrCpCwr2yGeTnHiyhlXPPmv
   M=;
X-CSE-ConnectionGUID: aaRhrpQ3Qf+x/TcO9CmreA==
X-CSE-MsgGUID: lt3DOhc7RO+3ARnRrg5gWQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267037076"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 10:14:04 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 544C4832C0; Tue, 10 Mar 2026 10:14:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 75DB0831BD
	for <cocci@sympa.inria.fr>; Mon,  9 Mar 2026 17:28:29 +0100 (CET)
X-CSE-ConnectionGUID: kSTeNPLDTFa7po1KeybgxQ==
X-CSE-MsgGUID: h9P+klt3Q9uv4njEVssPag==
IronPort-SDR: 69aef52e_zKAOKn7z09ll45kvN65MoJeiF8bHl/XO/7YltFTk5+BxaN5
 pQyxvH46HdBwRe/KfDKdKuUPydvw9qukqN+sUzw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FhDAAz9K5pfKrWVdFagQmBUoI/gQdfMwRUhFiPU4IhA?=
 =?us-ascii?q?4Q7hzmHWIh5gWmBLD0CDwEDAQsBAT0UBAEBAwQ4hEgCjSECHgcBBDQTAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABASIZBw4SKYZPDUkBA?=
 =?us-ascii?q?QQLAQQBggIBWExhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEKAg0fXgEBAQECARIRFQgBGxcGAQMMBgULDQICJgICIAIRAQUBHAYBEgIBA?=
 =?us-ascii?q?R6CYAGCIgEGEAEDDycCARGhLIECQopDeoEVBQIWgQGCDQbaZQoZKA1xgWQCA?=
 =?us-ascii?q?QYJAQoBAYEJLgGEdildAYI3HwGGDyCDRXonG32BEIE8gwM+gh9CA4ElAU6DR?=
 =?us-ascii?q?oJHIgSCIoEOiQyKDwgHHxIJCRMGCgJICwoSAwQDBAQBAgsTCQMDAg4CCAMCC?=
 =?us-ascii?q?AYZAT8SBBMKDQsHBR8KAgwUCigiBA4CKQoDIAosAy0BAQcGAgIDAQQCBAIKA?=
 =?us-ascii?q?gkCAgUEAwIKBwMEAQEIAgIDKgMBAxkICQgCCwURGAwLBQIKJwMPAQkDAh0XF?=
 =?us-ascii?q?AUIARE0CAYWARoHBQYLASEWFAEFDBEFAwIBAwQDAwMDAwIEAgcHCwwEBAQDB?=
 =?us-ascii?q?QMDBQYDAQMEAwgDCgIECw0GBQICAgECDAwDAwoEBAMCBQIGCQMCAwMBAwEDO?=
 =?us-ascii?q?RwTBAUCBQMDAToDDgQDCB4CAQECBgIBAwMIAgMBAwIHAxQFAQYIAgQECgIDA?=
 =?us-ascii?q?wcGBQcCESgEAgICAgQDAwMKBwcEAwEHAwMMAgIQAgQEAgMTAwMEAxADAQISG?=
 =?us-ascii?q?AYBAwcIAwIHBBYDAgkZBAIEAwICAgIBLgMFBwIEAQcBAwMHAwIMAgICEgUEB?=
 =?us-ascii?q?gIBAwwDBAMFBQstEQcTCgYEBwUCAgIUBgIEAQsSAwMEBAIBAgICOgQHAQIKG?=
 =?us-ascii?q?goEBAgHAwcBGAUCAwIFAQMBBwcSAgYECAIBDgESAgkCAgQCCQEBCg8CAQECB?=
 =?us-ascii?q?AICAQMIGAMEHwQDAwcCAgwJAwQNAhEBChIbAwMLAw0SBwQDDAoUBRcLDgQCC?=
 =?us-ascii?q?QgDDQILCwYFCgUZAgICBgIDAwMCBQkBAgEBAQEBAQECBwMDAwIDAwYDEQ4PA?=
 =?us-ascii?q?gELCQgTPQwHMgQ2AQYDCxQHBCUYaI14PoIzAVgJAyoqAiknSKYdaKAgcWiDP?=
 =?us-ascii?q?owejz6GAQYPBC+XUhSTBYgpkF0ijWeECZF/hQUCCgcHESQSgUkjgVwzGiOBA?=
 =?us-ascii?q?YI2TwMZD5IhhRPDcDY1AgE5AgcLAQEDCY0dgW2CSxU0gUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:qOVyxKGFF2ZS+b3GpLqEMseALOsnbusQ8zAXPo5KOGVom6uj5r
 yTdZUgpGLJYVMqMk3I9urwWpVoLUmsjqKdpLNhR4tKPzOW3VdATrsSjrcKqgeIc0afygce79
 YZT0EXMrzN5DNB/KHHCWeDYrAdKZW8gcSVrNab4XMoYw8CUc5dBsRCZjpz0HcaeOCOP/QEKK
 Y=
X-Talos-CUID: 9a23:aDqb5G1L6erXFFOLFy2fYrxfGfsZf1vl6FvsDUbnEWEwa7CEQ1CAwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3A67gxhA2+tyJFSrnKgTA3bjYOWzUj4/WWS0MJjc4?=
 =?us-ascii?q?/6tSaaSpyFgmGlwy+Tdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,109,1770591600"; 
   d="scan'208";a="266950148"
X-MGA-submission: =?us-ascii?q?MDEWR6sUMcNi8p8HU6bEhfD8Z12wL+5t6w11pC?=
 =?us-ascii?q?rMmtoNtzIOUyWhLqsSSxycVg8jfMrIlx9iCbD86lrAvzIo4VYcNcg1nt?=
 =?us-ascii?q?FOrUfXb57ZMtLte5vZMZovxtN62UPb0qb50UcGIV93akjLbftCVAZyax?=
 =?us-ascii?q?hYwqvbS9x29z6/2HK33em+GQ=3D=3D?=
Received: from mail-pl1-f170.google.com ([209.85.214.170])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 17:28:29 +0100
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae5636ab04so85041285ad.3
        for <cocci@inria.fr>; Mon, 09 Mar 2026 09:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073707; x=1773678507;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBQuohd/vt2LAF3I4JQSmNdjevqrT6nbat4LeA+5Cz4=;
        b=dxU9OZsboI4FIrVhq6zC5/yFQt00e2upqQy2FXyp4QaCs1VLoe9uLv2TuE5lWw7X4W
         bAh6iyX+EXXjv5IY2TIz29YQAUT4/Q2eFxmP574dQlvIGmTGVgOsUSDl9yAyfyr7qC9Y
         bnwyOwssl3u1Zt7iiaZbagzd6YjWA1nyXbYYYWwvBUAsJkCa3pk4tRf0qHVWpnMAnmWY
         OyfVlR3pf2eBDTcKiG5Gr/BIcuX8dFc+Hqn1AhhlIVijn4tst90u7RNwp2zXLOif7jbC
         h1dg8JvzgH3hyi662GC7Mv2qWkcYqERLzOM6RnuY6EeolaJvYM31aMJeK61Hfz6Sia28
         DcZA==
X-Gm-Message-State: AOJu0YyRUl6hj2W8TpLv7FzyEythLnTuV8eMigQpVG9C15htG9u673Qy
	avU5WMMPg4kEG5u8LbhpVque1mLgZJaLkfF45QtTApVvoGRfZdRufGj/
X-Gm-Gg: ATEYQzyPZBXyRdvjHDLzkFOLGTwrZ7vLJMWQL94KBWPIfeeXYtBuDUmjoC6vdl5rUr4
	ID7IgQz5guW2Y1nUzavcSionl8jtB8WQYpZS795LbvCTKJ+lJSyOzu7BWq6Z1AwNUdZYb6U9X+M
	Jyg58EcKskVkQZNQfYy1nswFJZwIhofABQ+qd2DpIktNBd6cwdCXuH545G6GN2AtBchvnIOi9IW
	D97JOJTeZQ7RsHHZ9iFLz+IUCFuF8AlHmbjuOEamqxFq9ggXEcZ/oz99cXzNnU4IfqQSeg7OSYX
	bfDY4u+pQl+U9Ccmt+laep3yWeooV1+ofqefCAkdrcwBYZ6Ar8tJeXeUWAhr53yYN1rNAiozO/+
	FyvSOLEgi50WXdFRiMOAOdwF7c9fEJ39eBvEjbBb4Fj8oUaYF4wIw2XH3IfSiFp+n4ZqJDXRgC7
	JGLpSG4qm3bjnA88YBYowOA0E045egZGj5NpYqOv1TmJTuXRPn2eQ7E/VGdxYsB81wfMiX
X-Received: by 2002:a17:903:2441:b0:2ae:4fdb:d596 with SMTP id d9443c01a7336-2ae82367db1mr122450805ad.11.1773073707067;
        Mon, 09 Mar 2026 09:28:27 -0700 (PDT)
Received: from [10.79.58.83] (wf121-083.ust.hk. [175.159.121.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e57cb1sm116837325ad.9.2026.03.09.09.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 09:28:25 -0700 (PDT)
Message-ID: <ae8dda71-9e25-4f3b-ab95-1b00809ade37@gmail.com>
Date: Tue, 10 Mar 2026 00:28:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jonathan Corbet <corbet@lwn.net>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Shuah Khan <skhan@linuxfoundation.org>
Cc: cocci@inria.fr, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260308100851.341-1-tttturtleruss@gmail.com>
 <87v7f5vv9x.fsf@trenco.lwn.net>
From: Haoyang Liu <tttturtleruss@gmail.com>
In-Reply-To: <87v7f5vv9x.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] docs/dev-tools: fix a broken URL in
 dev-tools/coccinelle.rst
Reply-To: Haoyang Liu <tttturtleruss@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3367
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/RylTSbYgkkxWhmT57SMzaA>


On 3/10/2026 12:10 AM, Jonathan Corbet wrote:
> LIU Haoyang <tttturtleruss@gmail.com> writes:
>
>> The original supplemental documentation for coccicheck is
>> https://bottest.wiki.kernel.org/coccicheck, which redirects to a not found page,
>> thus change it to https://bottest.wiki.kernel.org/coccicheck.html,
>> which adds a suffix to original URL to make it direct to the right page.
>>
>> Signed-off-by: LIU Haoyang <tttturtleruss@gmail.com>
>> ---
>>   Documentation/dev-tools/coccinelle.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
>> index 2b942e3c8049..f73ccf5397f3 100644
>> --- a/Documentation/dev-tools/coccinelle.rst
>> +++ b/Documentation/dev-tools/coccinelle.rst
>> @@ -61,7 +61,7 @@ Supplemental documentation
>>   
>>   For supplemental documentation refer to the wiki:
>>   
>> -https://bottest.wiki.kernel.org/coccicheck
>> +https://bottest.wiki.kernel.org/coccicheck.html
>>   
>>   The wiki documentation always refers to the linux-next version of the script.
> I'll apply this - a working URL is better than a broken one.  But is
> there really nothing better to link to than a page that warns "OBSOLETE
> CONTENT" at the top?

Dear Jon,

Unfortunately, I do not find any other documents about this script, so I 
have to use it even though it's obsolete.

Sincerely,
Haoyang

>
> Thanks,
>
> jon
