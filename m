Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC20BC5320E
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2024 07:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bJvtb82z38Pn6poTrc/QA9OsyK+YMvr+QBeVHjD/rTs=;
  b=fm1WfX++gK1XODuzKLiEmQmeYNkbpHmdID6//NZ44UXVcg5+czdY3/Dt
   FarB3uNp8t+iS6QZjAS+1nAgpgkFoBuIF311HBGmCh/kTjIZObUaNna66
   1ejZZ4X4obl/cgckQOIsdfmaZBDSunK8ElOt2ZFpqR7dp4U/ZJxriOvvy
   U=;
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.10,175,1719871200"; 
   d="scan'208";a="179963917"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Aug 2024 09:25:17 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E8DAE0145; Sun, 25 Aug 2024 09:25:17 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 300F4E00B7
	for <cocci@sympa.inria.fr>; Sun, 25 Aug 2024 09:25:14 +0200 (CEST)
IronPort-SDR: 66cadc59_jQsNRPIFSdVc9QdDyu58ZLKG2DGhpeCCwC3ZtnTQCYTfzwt
 lOAiRIfRzOrGLX+WdxX65FO/zx0DNC27/+cQd8w==
X-IPAS-Result: =?us-ascii?q?A0G7AACy28pmf7PQVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYFxUoFXMwRThFaRQS0DgRODKIc6k14+DwEDAQsBAUICBAEBAwQ4h?=
 =?us-ascii?q?EcCiWkCHgcBBDMGDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEiGQcOEimFdQ2CYwGBImECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBBQIsXgEBAQECARIRBAsBBQgBGx0BAwwGAwILDQICJgICI?=
 =?us-ascii?q?AIRAQUBHAYTAgEBHoJegjABAw4jAwGSeI80gQVCikF6fxYFAhaBAYINBtpaC?=
 =?us-ascii?q?hkoDWwDgWACBwkBCoEGLgGEcilbgjIEAR0BiWB6Jw+BVUSBFScLgQmBNzg+g?=
 =?us-ascii?q?h+COYNGgkciBIFpBYNngh+FMoFhD4JxDgGCEQqCClcPV3GBE4MQfCU+CwWHH?=
 =?us-ascii?q?4F7i0AIBx8SCQkTBgoCSwsKEgMEAwQEAQILEwkDAwIOAggDAggGDhMBPxIEE?=
 =?us-ascii?q?woNCwMGBR8IAgQHDBEKFwIDAwICAwIFAwMFBQUCAwUDBAMFAwMCEQEGAgUNC?=
 =?us-ascii?q?AYLBQUHAgYCBAgFAgIDAwMCBBADAwMCBQICAwMBAgYPBgICAwUGAwMDAwMGA?=
 =?us-ascii?q?wMCBgMDAgIDAgMBAwIDAQIDAgICCAICAwUEBQICBAgTAgICAgMDCAMDCgQCA?=
 =?us-ascii?q?gQBBAIEAgQGAgQCAgEGAgMDAgMCBwICBAICAgIDAgQFAgMDAwICAgEJAgUBA?=
 =?us-ascii?q?QYCAwMCAwUDCQMEBQIDCAEBAgIHBwMDBAMBAgEFBAICBgUCAwICBAIEBQMCA?=
 =?us-ascii?q?wYGAgEDAgoGAwUDAwMDAgMCAwMCBQIIAgIEBAUEAgUEAgQDAwMBCgIGAwICB?=
 =?us-ascii?q?QEBAgIFAwIEBAcCAgcPAwIHBQIFBQUCBwEGBQICAwIGAQICBgEGAgQBAg0BA?=
 =?us-ascii?q?QICAwEDAwMHAgQDAggCAwMPAQMDCQYFBAUEAwkEDwIEAQgDAQEECAIEAwIMA?=
 =?us-ascii?q?gIgAgULBAQaCAMBAQMBAQICAgINAwIDAgIDCgIDAgoGBAIEAQEBBAQBBAIBA?=
 =?us-ascii?q?gcEDgkFCAgBAwIBBAYBAhAFEAkDBwQCEAYKBQMCAwUBBRUDCAMJAgQMAwUIA?=
 =?us-ascii?q?gMCBgMGAgYBBgMHCwEBBwgFAwMDAhcBAgIPCAQGDwgCAwMDBAoDEgIGDgMDA?=
 =?us-ascii?q?gMCAQICAgMFBAUCBwMDCgUCCAMCCAUDBwkECgIKAgYDAgICAgUMAQEBAQIDA?=
 =?us-ascii?q?gUDBwcICAQFBAMBAQYGDB4CAgMEDwMJAwYLAQUFAQMCAg4DBgIDBgYBCQQBB?=
 =?us-ascii?q?QQJAgUHBgUCARQHDwUBAQYCCgIHAgICAwECCAkIAgMCCgQBDgQZAgUBAgIDB?=
 =?us-ascii?q?wIDAhMDAwUEBgMCAgICAwIBCgsDAgIDAwMDBQUDAhkDAwIBCgUMBQQDBAICA?=
 =?us-ascii?q?R0DAQUCAwoBBQkBBgICAwIFAgMGBAIEAQ4BAQEDBgsJFAICAgkIAwgDBQ0CD?=
 =?us-ascii?q?QIDBQICCz0LBQEBBAMJGC0CBAIGDAEBAQIDBgICAhUFBwMFAwgBAwECEwgGA?=
 =?us-ascii?q?gEDCgoCAgQCBgMDAgoDAQgCAgIPAwkCBwINAgIDAwwPBAMDAwMIAgICEQkKA?=
 =?us-ascii?q?gICDAQKAgkCAgMGAQIDAwUDAgEBAQQvAgQHAQMGCgMCAgIJCAoJAwMFAwwBB?=
 =?us-ascii?q?gQBAgMMAQECEwQJAwIBAgEBBggBAQIEAQQCCAYCAgICCgMFAwIDBRUFBAICG?=
 =?us-ascii?q?QMEBQMFAwMEBwECBQQLCQIFAwIEAwMCBAQCCAUJBAMLBgEBAQMEAwEBCAcHA?=
 =?us-ascii?q?wIBAQMBAQoLCA0IAwgDBgkDAQYBAQUSCAIDDgICAgMCAQoGCAUCAwYNAgQCG?=
 =?us-ascii?q?QEMAwEDAwUOBBQDBAUCAg8MAQIDAwQFAwUCAgIDAgICBQQBAgQCBAEIBAkBA?=
 =?us-ascii?q?gICAwIBAQIEBgUCAgIDAgcMBwMEAgYCBgIDAgcLCwIDBgUFAwUCHgIDAgIEA?=
 =?us-ascii?q?wMWAQEDAQIBAgMCAgMCAwQBAwMCAQEBAwcCAgIEAQEBBAYFAgIDDAIDAwEBB?=
 =?us-ascii?q?gEDAQIPBgUGBAEKAwIUAwUiAg8FCAEoAQQCAgECNwICAwQNCAUCAgcCBAwCB?=
 =?us-ascii?q?A8FAwMOBxYGAQQIBAUEBAwKAwYOBxcRAQEEBAIIBAICDQcCDAICBgQCAQMHI?=
 =?us-ascii?q?wYDBQkDAgUFEAICDQIEAxYEBBsDAQIKAgIYAgEHAQIUAgIHAgIBFAIKBAIHB?=
 =?us-ascii?q?gcCHQICAQMHBAQBCQMGDBEDCAIHAgEFBgUBAQQSAQIBAgEBAgMDEQECAgMDA?=
 =?us-ascii?q?gIBCQICAQECDQgBBAMBBgIFAwUDCgEBAQIBBAkEDwYDBQMDBwMEAgMCBgIEB?=
 =?us-ascii?q?AICAwMCAwEGAwIBAgMJAgEREQoPAgIDBAIGAgIBBC8EARUFAgMEAgIHAgIDA?=
 =?us-ascii?q?QIBAgICBAIFAgIGAwkIAQICCAECAgIDFgIFAQQJAwMFEg0jAwMBAgICAwcKA?=
 =?us-ascii?q?wUCAQECBAMFAwMJDQcCAwECAQMFAwECAQIJAwcCAgMDBRIZBQMCCAkDAgEFB?=
 =?us-ascii?q?AIJEgsJAQESGgUECQUVCQIDBhcLBAUDAwMBEQUODgICDAMdBQEEBwEDEwsDB?=
 =?us-ascii?q?AQCAwMDAxQCARcBAwQDAgkCBAECCgICAwMCBR8dAgkDIw8CAQsJCBM9DAcyB?=
 =?us-ascii?q?DQBCQsUBwYlGGioXYJHCFkhEwF/cXg9xCJNPTQHhBeBXQYMmVWFegYPBC+XP?=
 =?us-ascii?q?YxdhiiYb5F+lnACCgcGESMSgUgkgVwzGiNQMYI2TwMZD44hDBaDWMt3QTU7A?=
 =?us-ascii?q?gcBCgEBAwmFaYYBgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 gSRD7MC6Ihp5ayfNHB6CenExn6pbk8xMg==
IronPort-HdrOrdr: A9a23:Wi1Pn6iciab/8HtcAos6inLhvnBQXgMji2hC6mlwRA09TyVXrb
 HWoB1p726OtN93YgBepTngAtj9fZq4z/RICOYqTNWftWXdyRGVxcRZnPbfKl7bakjDH4xmpM
 RdmsFFYbWabWSSz/yKmDVQe+xA/DDtytHOuQ6x9QYKcegnUdAF0+67MGqm+49NKTWuyaBXKH
 NU3KR6mwY=
X-Talos-CUID: 9a23:4DoWRWMSZUozOO5DUSVM+25LK4MeSFrC4mncBk2WUzw1V+jA
X-Talos-MUID: 9a23:XddOjwZPzwJ0DOBTkhXluw5+F99T/4eNF1Ehzo0ng+reDHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,175,1719871200"; 
   d="scan'208";a="179963914"
X-MGA-submission: =?us-ascii?q?MDESWtZKgafND+7PYCSj25CscMwbKEQaEid5Ow?=
 =?us-ascii?q?LIDtRliG7AwfnoN59bZBTZ7bIZoNsHG0mugkDRv9Ex1ROlEw/r7xU1xd?=
 =?us-ascii?q?r7NpLuqZrlpQcu3aySEa9W0GveKTqj+ggzzHUEMhSTSH0Wtd8BKvspzc?=
 =?us-ascii?q?qOLDyHjhykMUJ+nw9xCUcV4Q=3D=3D?=
Received: from mail-lj1-f179.google.com ([209.85.208.179])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:25:13 +0200
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f4f2cda058so19701531fa.1;
        Sun, 25 Aug 2024 00:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724570712; x=1725175512; darn=inria.fr;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJvtb82z38Pn6poTrc/QA9OsyK+YMvr+QBeVHjD/rTs=;
        b=eta90sHu4lNXlpIFPHywxqVLxLksCnY3Ca/Q294v1nLRF3VC8h/EOz1nlBo7Sbql6h
         8Es7Gx+Gj0yfQjXlF/EfMnfPJQ+B1CpQzau/HKE+qNwxrTywXxo3RaNYXNdiO4O87+3O
         A3IlUqj0soqbym+kuBbXZxC0yTj+xtJDzUnEsuJOd5NpMChFE30RyI0GJOkdKilaYHPt
         Tv3ecx6UowKwNlvcHXifXxCM8BYoIS/xyco5g+IDCbFEcWsu7DE9XR67z7HZzlY5EwRK
         RpHF4AylF0TCP29onB4Ke/E4V0NMb4Q7QvTdbYQZzDIq6q4ix2fX6toBEM96VlCUWWS8
         5HEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724570712; x=1725175512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJvtb82z38Pn6poTrc/QA9OsyK+YMvr+QBeVHjD/rTs=;
        b=KQwwtPmuwWzg6VfOmoolytbTDuvDnvPukSBlS8+TsWBmu6iE9/lFZgxVvIPkbHMWnb
         SpwmBhKbgwumMrYJa+Rf3CveXqo6F9sod1VACggOWveA81NDZgbqraisfR+agAEsAj6X
         OOqxeCantCWat4foiGHUHE11twX3lok8N1s/oj/wwGtRWgf/XecksUAJrWakhjNKM48K
         OGLiT2U+4EZ6JEWdYAQ10E2yBkfdLXfaF5ljhfiGzCduiab/63gsVX2hMkTv0o5F5F+D
         ZL6TjvaYvOOWpLUvV4rkP8uzX+i0A1f0TXYDgiBzG9SB9QYTfR111CNnuatUzUd9VsDX
         KyWw==
X-Gm-Message-State: AOJu0Yw783OPJVO0WhR/JqzQpi5/3x4DufjSkefoAaq8Y+Oe8QgwIQm/
	vB9af5CBxkf8oWdY6ybfu0t6kRBsLZgREfYNq5wyMFP0SWYIkDkzULPN5A==
X-Google-Smtp-Source: AGHT+IG5rVFjMfWZpV+3M9IFMOsyXjunmktHNTmlgNDsjjlIpD8guqOvkvWYx1bXm36hCZYf12buBA==
X-Received: by 2002:a2e:b5a5:0:b0:2ef:1f5e:92be with SMTP id 38308e7fff4ca-2f4f490be5fmr20823021fa.9.1724570711279;
        Sun, 25 Aug 2024 00:25:11 -0700 (PDT)
Received: from ?IPV6:2a02:aa1:1143:b0f6:fcf0:cec4:787c:8181? ([2a02:aa1:1143:b0f6:fcf0:cec4:787c:8181])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f40484a5c9sm9073111fa.86.2024.08.25.00.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 00:25:10 -0700 (PDT)
Message-ID: <db729936-91ac-4851-ad65-73dc090ade6a@gmail.com>
Date: Sun, 25 Aug 2024 09:25:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <983f5490-ee27-4558-832f-6d5af7344b79@gmail.com>
 <25488C8C-BE4A-4182-BD19-4D04562CEC4A@inria.fr>
 <5dea7b1b-3e0c-40ec-af12-b15e2a66502a@gmail.com>
 <d6e69dbf-799f-e0a-ee55-2cac9a3555e2@inria.fr>
Content-Language: en-US
From: Mats Kindahl <mats.kindahl@gmail.com>
In-Reply-To: <d6e69dbf-799f-e0a-ee55-2cac9a3555e2@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Symbolic names in iso-files
Reply-To: Mats Kindahl <mats.kindahl@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1863
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/db729936-91ac-4851-ad65-73dc090ade6a%40gmail.com>

On 2024-08-24 20:09, Julia Lawall wrote:
>
> On Sat, 24 Aug 2024, Mats Kindahl wrote:
>
>> On 2024-08-24 14:56, Julia Lawall wrote:
>>        Can you just add semicolons in your isomorphism?
>>        Sent from my iPhone
>>
>>
>> Hi Julia,
>>
>> I assume you mean to write something like this:
>>
>>        Statement
>>        @ pg_return @
>>        @@
>>          PG_RETURN_VOID(); => return;
>>
>> But that fails with the same error message:
>>
>>        mats@abzu:~/lang/cocci/hacks$ spatch --sp-file lwlock.cocci
>>        code/lwlock.c
>>        init_defs_builtins: /usr/lib/coccinelle/standard.h
>>        iso main: parse error:
>>         File "./postgres.iso", line 4, column 2, charpos = 29
>>         around = 'PG_RETURN_VOID',
>>         whole content =   PG_RETURN_VOID(); => return;
> Thanks for the report.  I will check on it.
>
> Even without the isomorphism, you should be able to write a disjunction in
> your semantic patch?

Yes, of course, but it becomes quite cumbersome if you have to deal with 
this all the time, so this was more about an opportunity to improve the 
tool by recognizing yet another common situation in which macros are 
used as replacement for other constructs.

It is of course not possible to cover all weird macro uses, but the 
"iterator" pattern is quite common as is this "return" pattern.

/Mats

>
> julia
>
>> Best wishes,
>> Mats Kindahl
>>
>>
>>
>>              On 24 Aug 2024, at 14:23, Mats Kindahl
>>              <mats.kindahl@gmail.com> wrote:
>>
>>
>>        ﻿Hi all,
>>
>>        In some code, there are macros used for different
>>        purposes. One typical case is having a "foreach" macro,
>>        but this is covered using "iterator" so that you can deal
>>        with code like this:
>>
>>              static Jsonb *BuildJsonObject(List *items) {
>>                ListCell *cell;
>>                JsonbParseState *state = NULL;
>>                JsonbValue *value;
>>
>>                pushJsonbValue(&state, WJB_BEGIN_OBJECT,
>>              NULL);
>>                foreach (cell, items) {
>>                  KVItem *item = (KVItem *)lfirst(cell);
>>                  AddJsonField(&state, item->key,
>>              item->value);
>>                }
>>                value = pushJsonbValue(&state,
>>              WJB_END_OBJECT, NULL);
>>
>>                return JsonbValueToJsonb(value);
>>              }
>>
>>        However, if you want to make sure to deal with resource
>>        allocation and make sure that you release a short-lived
>>        lock, for example (grossly simplified, just to demonstrate
>>        the problem):
>>
>>              @@
>>              expression lock, mode;
>>              @@
>>                LWLockAcquire(lock, mode);
>>                ... when exists
>>              (
>>                LWLockRelease(lock);
>>              |
>>              + LWLockRelease(lock);
>>                return;
>>              )
>>
>>        If fails miserably with this code:
>>
>>              Datum start_worker(PG_FUNCTION_ARGS) {
>>                pid_t pid;
>>
>>                if (!autoprewarm)
>>                  ereport(ERROR,
>>              (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),
>>                                  errmsg("autoprewarm is
>>              disabled")));
>>
>>                apw_init_shmem();
>>                LWLockAcquire(&apw_state->lock,
>>              LW_EXCLUSIVE);
>>                pid = apw_state->bgworker_pid;
>>
>>                if (pid != InvalidPid)
>>                  ereport(ERROR,
>>              (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),
>>                                  errmsg("autoprewarm worker
>>              is already running under PID %d",
>>                                         (int)pid)));
>>
>>                apw_start_leader_worker();
>>
>>                PG_RETURN_VOID();
>>              }
>>
>>        Giving the patch, where the call to LWLockRelease should
>>        be before the PG_RETURN_VOID:
>>
>>              --- code/lwlock.c
>>              +++ /tmp/cocci-output-12611-ff946d-lwlock.c
>>              @@ -18,6 +18,7 @@ Datum
>>              start_worker(PG_FUNCTION_ARGS) {
>>                apw_start_leader_worker();
>>               
>>                PG_RETURN_VOID();
>>              +  LWLockRelease(&apw_state->lock);
>>              }
>>
>>        Since this is such a common construct, and you do not want
>>        to deal with this for every potential case, this seems
>>        like an obvious case for using an iso-file, so I created
>>        one that looks like this, with the idea that we support
>>        replacing "PG_RETURN_VOID()" with just a "return".
>>
>>              Statement
>>              @ pg_return @
>>              @@
>>                PG_RETURN_VOID() => return
>>
>>        However, this fails with the following error message:
>>
>>              mats@abzu:~/lang/cocci/hacks$ spatch --sp-file
>>              lwlock.cocci code/lwlock.c
>>              init_defs_builtins:
>>              /usr/lib/coccinelle/standard.h
>>              iso main: parse error:
>>               File "./postgres.iso", line 4, column 19,
>>              charpos = 46
>>               around = '=>',
>>               whole content =   PG_RETURN_VOID() => return
>>
>>        Which I suppose mean that there is no support for handling
>>        anything but standard tokens in an .iso file.
>>
>>        Have I misunderstood the situation and this is already
>>        supported in some way?
>>
>>        Are there any plans that add such support to the ISO
>>        grammar?
>>
>>        Best wishes,
>>        Mats Kindahl, Timescale
>>
>>
> >
