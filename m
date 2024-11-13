Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5440ED637A3
	for <cocci@archiver.kernel.org>; Wed, 13 Nov 2024 17:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EX83NCwa0N27BcnEYdwWd+MMSNtAMk59QPSk8Udjw+k=;
  b=M38rb9jklhwPNRDIRbCOMNICxaZ06awTsJNnJZe/A/jvfbi9jbY/yA6r
   KRt5PJh9S6OuY3Aav/OeYtlPG0W6pagDargKU64uTGcLddXungYmi5hJW
   FW/Vk11DpfnCJzkMeLzWNs8R7YZ9tAoIsWJNLQ1bN5BB3qfodqjkymXNd
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.12,151,1728943200"; 
   d="scan'208";a="193702748"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Nov 2024 18:38:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 561D7E0D1E; Wed, 13 Nov 2024 18:38:25 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3A5F3E00B7
	for <cocci@sympa.inria.fr>; Wed, 13 Nov 2024 18:38:22 +0100 (CET)
IronPort-SDR: 6734e40d_8qJ+AGx6jbDYr0YENrarPgHIiFHT6pIUR3A2oqMyLEIHQuS
 6n/2megdk26W3v5L0YX0bboteiq1LUtAgX9vU8w==
X-IPAS-Result: =?us-ascii?q?A0HlBQBy4zRnfLHQVdFaHgEBCxIMQIFIC4FyUoFXMwRTh?=
 =?us-ascii?q?FaPTYF0LQOEO4c6kEqBVoFAPg8BAwELAQFCAgQBAQMEOIRIAopEAh4HAQQyB?=
 =?us-ascii?q?w4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBIhkHDhIphXsNg?=
 =?us-ascii?q?mIBgSRhAgUDOwEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QUCLF8BAQEDEhEECwEFCAEbHQEDDAYFCw0CAiYCAiIRAQUBHAYVAQEegl+CM?=
 =?us-ascii?q?AEDMQMBpEuBBUKLPn8WBQIWgQGCDQbaXAoZKA1sA4FhAgcJAQqBBi6EcylOD?=
 =?us-ascii?q?oI3AxoBBW2IdHonD4FVRIE8C4JHMT6EWINGgmkEgkF6PYJwdiVNiEqKdI4XC?=
 =?us-ascii?q?AcfEgkJEwYKAksLChIDBAMEBAECCxMJAwMCDgIIAwIIBh8BPxIEEwoNCwcFH?=
 =?us-ascii?q?woHDBEKKAQiBA8SHBADMgMEBQMFAwMEBwECBQQJCAEFAwIEAwMCAgMCCAUHB?=
 =?us-ascii?q?AMKBgEBAQMEAwEBBQcHAwIBAQMBAQoLCA0FAwgDBgkDBAEBBQ0IAgMOAgICA?=
 =?us-ascii?q?wIBCgYIBQEDBiEBDAMBAwMFDAQUAwQFAgIPDAECAwMHAwUCAgICAgICBQQBA?=
 =?us-ascii?q?gQCBAEIBAkBAgICAwIBAQYEAgICAwIHDAcDBAIGAgYCAwIHCwoCAwYFBQMFA?=
 =?us-ascii?q?h4CAwICBAMDFQEBAwECAQIDAgIDAgMEAQMDAgEBAQMHAgICBwYFAgIDDAIDA?=
 =?us-ascii?q?wEBBgECAQIPBQUGBAEKAwIUAwUiAg8FCAEmAS0CAgMEDQgFAgIHAgQMAgQPB?=
 =?us-ascii?q?QMDDgYWBgEECAQGBAwKAwQOBxcRAQEEBAITBwILAgIGBAICByMGAwUIAwIFB?=
 =?us-ascii?q?RACAgsCBAMVBAQbAwECCAICGAIBBwECEgEHAgIBFAIKAwIFBgcCHAICAwMEB?=
 =?us-ascii?q?AMBBQMEEAMLAQUGBQEBBA4BAgECAQECAwMOAQICAwMCAgEJAgIBAQINCAEEA?=
 =?us-ascii?q?wEHAgUDBQMKAQEBAgEECQQPBgMFAwMHAwQCAwIGAgQIAgIDAwIDAQMDAgECA?=
 =?us-ascii?q?wkCAQ8PCg8CAgMEAgYCAgEEJgIBFQUCAwQCAgcCAgMBAgECAgIEAgQCAgYDC?=
 =?us-ascii?q?QgBAgIHAQICAgMVAgUBBAkDAwUSDCIDAgICAgMHCgMFAgEBAgQDAwMDDA0HA?=
 =?us-ascii?q?gMBAgEDBQMBAgECCQMGAgIDAwUSGQUDAg8DAgEFBAIIEgsHAQEPFgUECQUVA?=
 =?us-ascii?q?wYCAwMWCwQFAwMDAQwFDA4CAgsDFwUBAQcBAw4IAwQEAgMDCQIBEAEDBAIJA?=
 =?us-ascii?q?gQBAgoCAgICAgQBAQUEAgQDAgUCAgEIBAMDAw0EAwgIAwUDDBICAgIJAgMBA?=
 =?us-ascii?q?gMDAwQNCBYNAwINGgoVEwcHAwMECwIJAwQNAgQCAgEGAwYKBgcEBQYBAhgCA?=
 =?us-ascii?q?gYMBAMDCAMCAwICAQICAgERAgIJCA0FCQUGAhYDAgMIAQkDDwMCFAEGAggDB?=
 =?us-ascii?q?wEBBAICChMKAQECAgEGKAMBAQIUFAcDCAICAgIGFgwBBQcDBw8FBQQCAhYDA?=
 =?us-ascii?q?xUEBAwCBQICAwMCAQEUBhUBBQIDBgsBBgECBQQCAwQCFAISAwQDCgIPAwYDB?=
 =?us-ascii?q?AYDAQIMEAIEAgkLAQUEAwcFAh8DAwICBQsCCAICBQIFBwMJCwYBAggDBAkCF?=
 =?us-ascii?q?AIQAgICAggUBwICAgIFHgMmAgQDAwMDCwECAg4JAwRDBhMEAgMDAg4BAgILA?=
 =?us-ascii?q?QICBAIDAQQHCQMDCQoHAQoNBwICCggJEAECAg8HAwICAgIGBxEDAhMPBQYGA?=
 =?us-ascii?q?goHDQoDAgECAhMCAwkGAwUNAwcECg8CFwIYBQMhAggJCwIHEAUCBRMDGh0CC?=
 =?us-ascii?q?QMjDwIBCwkIEz0MBzIENAEJCxQHBiUYaJ8og0VnE4FxWliSWpNYnxg0B4Qdg?=
 =?us-ascii?q?V0GDJ9WBg8EL5c/kw6Yd6NOhSsCCgcGESMSgTkOJYFcMxojgQGCNk8DGQ+OI?=
 =?us-ascii?q?QwWg1jFa0I1OwIHAQoBAQMJhWmJF4FLAQE?=
IronPort-PHdr: A9a23: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
 5WrqiAYsz8=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:QOwmFa5OF1lKW3DYeQPXwBHXdLJyesId70hD6qm+c20tTiXqrb
 HUoB19726KtN9xYgBdpTnkAsO9qBznhPxICOUqTM2ftUzdyRaVxeJZnO7fKl/bak7DH4dmvM
 8KE5SWSueAdWSS5fya3ODSKadG/DDoytHPuQ6T9QYIceioUc1dBsVCZzpz3ncYeOCOP/QEKK
 Y=
X-Talos-CUID: =?us-ascii?q?9a23=3AOBzVzmr8QAVMSMlBrPbpkl3mUdsIbSbZ3GbWGn3?=
 =?us-ascii?q?iKlZXQr2uZmPO1Ioxxg=3D=3D?=
X-Talos-MUID: 9a23:BqjxRAT0Hz94QqgnRXTtuBVoFPkruJ2tFUchrKoCt5iOHxFJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,151,1728943200"; 
   d="scan'208";a="101527405"
X-MGA-submission: =?us-ascii?q?MDHPCfzwyINred2B/Hnx+TnI1MHlYF1eE7t56X?=
 =?us-ascii?q?lF54PFQ138d23u/w6IsHJaMIMXZ2JcnqTeJw5VVYbtYgZkicTrVijfEi?=
 =?us-ascii?q?e0RbmPn/v4kdyLGz9IzJHvmxTeiZ3hH+raQYHUbeeN+zh5+HvKcKyr78?=
 =?us-ascii?q?U9qTJtuMxiUKUqqEBP8fzGaA=3D=3D?=
Received: from mail-lj1-f177.google.com ([209.85.208.177])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 18:38:21 +0100
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so49424341fa.1;
        Wed, 13 Nov 2024 09:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519499; x=1732124299; darn=inria.fr;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EX83NCwa0N27BcnEYdwWd+MMSNtAMk59QPSk8Udjw+k=;
        b=H5cmMdcxnbeRJNKSDrGXiM4FbreccgrrYXHNJOdOk/lQ5bzztdfIdn1wJUknT4lFSo
         HYRWgSzJ1SenHy1SzIqydRZQYYZi7oNbVYTQglzQVuOf9pmewJ9mSLBrx2idBViYqFl4
         v7vJb/qwiCG3AGEQW365PKkd9WFN04Sie8/dUiDURIo7Heg/HEkiSK6sCRFJdFvM5t+E
         kg30o416ggYdtTp/r0WwPh/ev41GVfhHgRp+J8Pet3fg6DNv69m0RGs+p4CN+tshW9uU
         WlFyguwQn9lrAQJRjKR6QBerDWe0R/9R2vGzObyEfWJ8FeqU+MFTS+jfWeWoAUsu0R/z
         9Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519499; x=1732124299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EX83NCwa0N27BcnEYdwWd+MMSNtAMk59QPSk8Udjw+k=;
        b=pczPmvfbY2tDh0iZcd3Aq4/cBoceIqZ+7pVSNDiQOSwFM2arRWX7XWoA4SRkeZRyl9
         rXMpO0xbwiFDfEzad3huSLt/J8mpAmIYM+oMFZhTjzo+F5RnsFEG+24MCOL3okTHDHK4
         2OKoalbh1TejXLU1ImPfsnBgXgW79yKGiaX5NQMcc40bZE8uiR4emVIoTggMQS6qo+jT
         asurBb7AAG/5QbYJehv7sQuXwl1Ez1PSovvFR9gn1/rQ12QuhbySY0Wt2RkQqVtfkAzk
         Bo9usha4HIs7YzVeZbE8ZFilSSDVXBl+Xgjfi+yUejg9nyM0kYV8k2mcfYS6hXRwWfd8
         RZ5A==
X-Gm-Message-State: AOJu0Yy1l6KKUSfGIFBfVPsa9bC/3aZQPGR2QPDMnmlc1klzPRpOjO5Z
	0UfcQGeBUyYk6thV9M1aqAsADd2ihtMAkzc4rETVY5UgB26FQHIs0Y3RbA==
X-Google-Smtp-Source: AGHT+IF9OXRdPPDFWF8aN3yN1L5p1kzJANBkFShPqeYm2k3weqFqYPXHsXDcQQTRIR5HmLi6Jh6/IQ==
X-Received: by 2002:a2e:9a0a:0:b0:2fb:3e27:cbef with SMTP id 38308e7fff4ca-2ff201bc2c9mr100220421fa.23.1731519498333;
        Wed, 13 Nov 2024 09:38:18 -0800 (PST)
Received: from ?IPV6:2a02:aa1:1656:81ae:c3b:2b43:5ac5:5363? ([2a02:aa1:1656:81ae:c3b:2b43:5ac5:5363])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff178f3ba1sm24034601fa.35.2024.11.13.09.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 09:38:17 -0800 (PST)
Message-ID: <ff0cdac1-44de-4f76-9454-be92855ffc6f@gmail.com>
Date: Wed, 13 Nov 2024 18:38:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <f59fb941-f9a9-455c-a369-f764e33323e8@gmail.com>
 <dfdf92b9-24d-5535-f066-1ad816d6c6e@inria.fr>
 <31ac8b31-47ee-8d41-aa12-6d37c69790bc@inria.fr>
Content-Language: en-US
From: Mats Kindahl <mats.kindahl@gmail.com>
In-Reply-To: <31ac8b31-47ee-8d41-aa12-6d37c69790bc@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] How to add error handling code before first use
Reply-To: Mats Kindahl <mats.kindahl@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 2000
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/ff0cdac1-44de-4f76-9454-be92855ffc6f%40gmail.com>

On 2024-11-13 16:13, Julia Lawall wrote:
>
> On Mon, 11 Nov 2024, Julia Lawall wrote:
>
>>
>> On Mon, 11 Nov 2024, Mats Kindahl wrote:
>>
>>> Hi again,
>>>
>>> I am trying to match code like the following and add error handling to it:
>>>
>>>        #include <postgres.h>
>>>
>>>        void foo(Oid id) {
>>>          HeapTuple tuple;
>>>          Form_pg_proc fd;
>>>
>>>          tuple = SearchSysCache1(PROCOID, ObjectIdGetDatum(id));
>>>          fd = (Form_pg_proc)GETSTRUCT(tuple);
>>>
>>>          if (strcmp("magic", NameStr(fd->proname)) != 0)
>>>            printf("Bad magic\n");
>>>        }
>>>
>>> The semantic patch I have for this is:
>>>
>>>        @@
>>>        identifier tuple;
>>>        expression id, cache;
>>>        statement S;
>>>        @@
>>>          tuple = SearchSysCache1(cache, ObjectIdGetDatum(id));
>>>          ... when != tuple
>>>        (
>>>          if (<+... HeapTupleIsValid(tuple) ...+>) S
>>>        |
>>>        + if (!HeapTupleIsValid(tuple))
>>>        +   elog(ERROR, "cache lookup failed for %u", id);
>>>          (<+...tuple...+>);
>>>        )
> Hello,
>
> The problem is that first Coccinelle uses the isomorphism and drops the
> ().  Then the code that merges the + code with the context code sees code
> added before a <+... ...+>, which it doesn't like.
>
> To solve this you should be able to do something like the following (I
> simplified it a bit):
>
> @@
> identifier tuple;
> expression id, cache;
> statement S;
> @@
>     tuple = SearchSysCache1(cache, ObjectIdGetDatum(id));
>     ... when != tuple
> (
> + if (!HeapTupleIsValid(tuple))
> +     elog(ERROR, "cache lookup failed for %u", id);
>     S
> &
>     (<+...tuple...+>);
> )
>
> julia


Hi Julia,

Tested your suggestion and it works well. Thanks!

Best wishes,
Mats Kindahl

>
>
>
>
>
>>> However, when executing spatch, I get the following error:
>>>
>>>        mats@abzu:~/lang/cocci/postgres$ spatch --all-includes --sp-file heap_tuple.cocci code/heap_tuple.c
>>>        init_defs_builtins: /usr/lib/coccinelle/standard.h
>>>        before [[Tag29 ("{", 0)]; [Tag22 ((Tag1 ((Tag5 (("if", (11, 2, 0, 0, " "), Tag2 (0), 0), ("(", (11, 5, 0, 0, " "), Tag2 (0), 0), (Tag9 ((Tag3 (((
>>>        ((("HeapTupleIsValid", (11, 7, 0, 0, ""), Tag2 (0), 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
>>>        ("(", (11, 23, 0, 0, ""), Tag2 (0), 0), ([(((Tag1 ((("rule starting on line 1", "tuple"), (11, 24, 0, 0, ""), Tag2 (0), 0), 1, 0, 0), 11, 0, 0,
>>>        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)], 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (")", (11, 29, 0, 0,
>>>        ""), Tag2 (0), 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (6, (11, 6, 0, 0, ""), Tag2 (0), 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
>>>        (")", (11, 30, 0, 0, ""), Tag2 (0), 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (Tag8 ((Tag4 (((Tag3 (((((("elog", (12, 4, 0, 0, "   "), Ta
>>>        g2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), ("(", (12, 8, 0, 0, ""), Tag2 (0), 0), ([((
>>>        ((("ERROR", (12, 9, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0); (Tag26 (("
>>>        ,", (12, 14, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0); (Tag1 ((("cache lookup failed for %u", 4), (12, 16, 0, 0, " ")
>>>        , Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0); (Tag26 ((",", (12, 44, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
>>>        , 1, 0); (Tag22 ((("rule starting on line 1", "id"), (12, 46, 0, 0, " "), Tag2 (0), 0), 1, 0, 0, 0, 0, 0), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
>>>        , 0)], 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (")", (12, 48, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), (";", (1
>>>        2, 49, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (0, 0, 0, Tag1 (0, 0)))
>>>        , 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0))]]
>>>        context tree should not have bad code before
>>>
>>> First, what is causing the error?
>> I think the + code in the disjunction, based on the (mostly unreadable)
>> complaint.
>>
>>> Second, is the semantic patch supposed to work or is another method preferred?
>> It looks ok to me.  Actually, I have never seen this complaint.  I will
>> look into it.
>>
>> julia
