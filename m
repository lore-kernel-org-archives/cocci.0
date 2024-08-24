Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689A5C52D6F
	for <cocci@archiver.kernel.org>; Sat, 24 Aug 2024 12:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NCQQXggUeaczy+P8PrMioghWuQz96sj9VqsahAka+9k=;
  b=F5M41PY7zQig/ToaJOjhYgI6JA0PGS1ariLPNRJOYfiEOzmIHE9BREhg
   Mx7uPy1nHwNHPtdXCyaZ2J8Vu47T5rFzzQ5IBWuwYppixkSlNn1whpm9U
   iSsfwCe+jpUpyt4w/gET8zYmqJe/nZ5nXkbfqzhqyhmJZcKwv99CFv5Pt
   o=;
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
X-IronPort-AV: E=Sophos;i="6.10,173,1719871200"; 
   d="scan'208,217";a="179930927"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2024 14:23:44 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5F719E0141; Sat, 24 Aug 2024 14:23:44 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9EFB7E00B7
	for <cocci@sympa.inria.fr>; Sat, 24 Aug 2024 14:23:39 +0200 (CEST)
IronPort-SDR: 66c9d0ca_IZZ1eEjLsVmL+1ju0t3GEjWkou/1KibBi+xncVbFMGY2KUI
 kGnsccwyWmJLpxllOLj+ByC0c38V4CAkkBZSBVQ==
X-IPAS-Result: =?us-ascii?q?A0EVCgC/z8lmfyunVdFaHQEBPAEFBQECAQkBgWQCgXBSg?=
 =?us-ascii?q?VczBFOEVo9MgXUthD6HOotIiBY+DwEDAQwBFAEtAgQBAQMEjmoCHgcBBDMGD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEiGQcOEimFdQ2CX?=
 =?us-ascii?q?IEqYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFA?=
 =?us-ascii?q?ix3EQQZARseAxIDDTcCJBEBBQE3AQEegl6CMAEDMQMBkX2PNIEFQos7fxYFA?=
 =?us-ascii?q?haBAYINBoJo13IKGSgNbAOBYAIHCQEKgTQBhHIpW4I3HQEqgTICiAKBIQ+BV?=
 =?us-ascii?q?USBFScLgQmKS4JHIgSHdIUygWGDDoISCoIKVw+CW4MQfCWHbYF7i0AIBx8SC?=
 =?us-ascii?q?RwGCgJLBRASAwQDBAQBAgsJCgkDAwIOAggDAggGDhMBPxIEEwoNCwMGBR8IA?=
 =?us-ascii?q?gQHDBEKFwIDAwICAwIFAwMFBQUCAwUDBAMFAwMCEQEGAgUNCAYLBQUHAgYCB?=
 =?us-ascii?q?AgFAgIDAwMCBBADAwMCBQICAwMBAgYPBgICAwUGAwMDAwMGAwMCBgMDAgIDA?=
 =?us-ascii?q?gMBAwIDAQIDAgICCAICAwUEBQICBAgTAgICAgMDCAMDCgQCAgQBBAIEAgQGA?=
 =?us-ascii?q?gQCAgEGAgMDAgMCBwICBAICAgIDAgQFAgMDAwICAgEJAgUBAQYCAwMCAwUDC?=
 =?us-ascii?q?QMEBQIDCAEBAgIHBwMDBAMBAgEFBAICBgUCAwICBAIEBQMCAwYGAgEDAgoGA?=
 =?us-ascii?q?wUDAwMDAgMCAwMCBQIIAgIEBAUEAgUEAgQDAwMBCgIGAwICBQEBAgIFAwIEB?=
 =?us-ascii?q?AcCAgcPAwIHBQIFBQUCBwEGBQICAwIGAQICBgEGAgQBAg0BAQICAwQDAwcCB?=
 =?us-ascii?q?AMCCAIDAw8BAwMJBgUEBQQDCQQPAgQBCAMBAQQIAgQDAgwCAiACBQsEBBoIA?=
 =?us-ascii?q?wEBAwEBAgICAg0DAgMCAgMKAgMCCgYEAgQBAQEEBAEEAgECBwQOCQUICAEDA?=
 =?us-ascii?q?gEKAQIQBRAJAwcEAhAGCgUDAgMFAQUVAwgDCQIEDAMNAgMCBgMGAgYBBgMHC?=
 =?us-ascii?q?wEBBwgFAwMDAhcBAgIPCAQGDwgCAwMDBAoDEgIGDgMDAgMCAQICAgMFBAUCB?=
 =?us-ascii?q?wMDCgUCCAMCCAUDBwkECgIKAgYDAgICAgUMAQEBAQIDAgUDBwcICAQFBAMBA?=
 =?us-ascii?q?QYGDB4CAgMEDwMJAwYLAQUFAQMCAg4DBgIDBgYBCQQBBQQJAgUHBgUCARQWB?=
 =?us-ascii?q?gEGAgoCBwICAgMBAggJCAIDAgoEAQ4EGQIFAQICAwcCAwITAwMFBAYDAgICA?=
 =?us-ascii?q?gMCAQoLAwICAwMDAwUFAwIZAwMCAQoFDAUEAwQCAgEdAwEFAgMKAQUJAQYCA?=
 =?us-ascii?q?gMCBQIDBgQCBAEOAQEBAwYLCRQCAgIJCAMIAwUNAg0CAwUCAgs9CwUBAQQDC?=
 =?us-ascii?q?RgtAgQCBgwBAQECAwYCAgIVBQcDBQMIAQMBAhMIBgIBAwoKAgIEAgYDAwIKA?=
 =?us-ascii?q?wEIAgICDwMJAgcCDQICAwMMDwQDAwMDCAICAhEJCgICAgwECgIJAgIDBgECA?=
 =?us-ascii?q?wMFAwIBAQEELwIEBwEDBgoDAgICCQgKCQMDBQMMAQYEAQIDDAEBAhMECQMCA?=
 =?us-ascii?q?QIBAQYIAQECBAEEAggGAgICAgoDBQMCAwUVBQQCAhkDBAUDBQMDBAcBAgUEC?=
 =?us-ascii?q?wkCBQMCBAMDAgQEAggFCQQDCwYBAQEDBAMBAQgHBwMCAQEDAQEKCwgNCAMIA?=
 =?us-ascii?q?wYJAwEGAQEFGgIDDgICAgMCAQoGCAUCAwYNAgQCGQEMAwEDAwUOBBQDBAUCA?=
 =?us-ascii?q?g8MAQIDAwQFAwUCAgIDAgICBQQBAgQCBAEIBAkBAgICAwIBAQIEBgUCAgIDA?=
 =?us-ascii?q?gcMBwMEAgYCBgIDAgcLCwIDBgUFAwUCHgIDAgIEAwMWAQQBAgECAwICAwIDB?=
 =?us-ascii?q?AEDAwIBAQEDBwICAgQBAQEEBgUCAgMMAgMDAQEGAQMBAg8GBQYEAQoDAhQDB?=
 =?us-ascii?q?SICDwUIASgBBAICAQI3AgIDBA0IBQICBwIEDAIEDwUDAw4HFgYBBAgEBQQED?=
 =?us-ascii?q?AoDBg4HFxEBAQQEAggEAgINBwIMAgIGBAIBAwcjBgMFCQMCBQUQAgINAgQDF?=
 =?us-ascii?q?gQEGwMBAgoCAhgCAQcBAhQCAgcEARQCCgQCBwYHAh0CAgEDBwQEAQkDBgwRA?=
 =?us-ascii?q?wgCBwIBBQYFAQEEEgECAQIBAQIDAxEBAgIGAgIBCQICAQECDQgBBAMHAgUDB?=
 =?us-ascii?q?QMKAQEBAgEECQQPBgMFAwMHAwQCAwIGAgQEAgIDAwIDAQYDAgECAwkCARERC?=
 =?us-ascii?q?g8CAgMEAgYCAgEELwQBFQUCAwQCAgcCAgMBAgECAgIEAgUCAgYDCQgBAgIIA?=
 =?us-ascii?q?QICAgMWAgUBBAkDAwUSDSMDAwECAgIDBwoDBQIBAQIEAwUDAwkNBwIDAQIBA?=
 =?us-ascii?q?wUDAQIBAgkDBwICAwMFEhkFAwIICQMCAQUEAgkSCwkBARIaBQQJBRUJAgMGF?=
 =?us-ascii?q?wsEBQMDAwERBQ4OAgIMAx0FAQQHAQMTCwMEBAIDAwMDFAIBFwEDBAMCCQIEA?=
 =?us-ascii?q?QIKAgIDAwIFHx0CCQMjDwIBCwkIEz0MBzIENAEJCxQHBiWBAKZJBA6ESWEhE?=
 =?us-ascii?q?wF/cXieI6Y8gQo0B4QXBYFYBgyfTwYPBC+XPZMFmG+obgIKBwYRIxKBSCSBX?=
 =?us-ascii?q?DMaI1AxgjZPAxkPji0Wg1jLUUE1OwIHAQoBAQMJhWmGAYFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZC5mLak53MWqnJZsA49hU0DlHX/pDfId3DAbv31ZSRFFG/Fw5P
 re+sjztCWE6wr5PUtLpTnuAtjkfZqxz+8M3WBzB8bHYOCFghrLEGgK1+KLqF3d8kXFl9K1vp
 0QCJSWZueAdGSSwfyKhzVQ0OxN/DBEys2VbCvloEuFhDsFV51d
X-Talos-CUID: 9a23:jU5QlW03CAb9j5Z1+mjCx7xfS58ASVSN7FXsO07mAyEqTaLJdnK/9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AgXsjbA60Ej4/Y2YteO6G8BN/xox3vJusF2UCoK9?=
 =?us-ascii?q?Xqo7cOSV8ZTm4oBqeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,173,1719871200"; 
   d="scan'208,217";a="94616029"
X-MGA-submission: =?us-ascii?q?MDGBAF0dHnuEtSDrlrjL2T13p/W96F7q2vz2GT?=
 =?us-ascii?q?7qA+rSN0YSpXoEn6VtsdeU/QKQFL8ICZTAqxKSeinNsfhSlYpJEZ42v8?=
 =?us-ascii?q?k2+Orya5BYgV1QnQuk1/wkD+gcz43el+U6YrLIx6exUWwDjkfku7d0u6?=
 =?us-ascii?q?/IfRwfNcizLBkRYrylKPjKsw=3D=3D?=
Received: from mail-lf1-f43.google.com ([209.85.167.43])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 14:23:38 +0200
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5343e75c642so973353e87.2
        for <cocci@inria.fr>; Sat, 24 Aug 2024 05:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724502217; x=1725107017; darn=inria.fr;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NCQQXggUeaczy+P8PrMioghWuQz96sj9VqsahAka+9k=;
        b=IQV9OnrMu1JqTLecnS1DJunWPdWQ6xfHN98S01EZ3odTybKcOc43Gq4GlSznWNNVVn
         OoY96S1IR/kOD8kmx4yF7EfwsKlxx1vRFQqj+jEaXdaBrvqx9baelIqba8+9QGN9wXVg
         yBU+TjOURG7cIdf0MViBpsgEf7bEOnsh1RZXAnaGMX3ESabYU6VuQvD3MGue28bKJ7gI
         q27Ydm/LL5pNul4/PYxHJslk9CDDLVLJ8oxxuvvieDNAR2DXzh/YWgbp7KLr5YN7/Rx2
         /Vz0tGjuwCmliw6TSlRR/UDA+qR3ENQEh2fV9q3TL9tO4+UuXwt5gvKrD+D3Y9DwK4Eo
         +S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724502217; x=1725107017;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCQQXggUeaczy+P8PrMioghWuQz96sj9VqsahAka+9k=;
        b=ifXVo2o5VeIh7VWit7hGzOaWwDzxRvdCy17Dyz/vQUbLLy4yGXu6py5udNgjyjsw1c
         xVfQHOJpZNM2uPWJV0WUnNGDXmRkHHlMSOEcg/tAWiYBjiYaW5It3MZ+kVw/4Wzzstey
         bvsRozRIYMIsshSuZi2TnWHAaW8cn9ia/Kfrmx3TAevce4PKoaSGmgslO827p/HHG9+6
         PWgGGhIilyaqCm7aTrVUfyYAFc6A+am0rQHnvBdZ9QzXWXSZSwcVAKOi5QAbGrGF1ZQx
         9obDLlBGUbwuQKgOusj5vIKOHcYBbCfKp+4dSMfb2KwAzXnaQLoYyvTdLxUacjn/Y4t4
         UMPA==
X-Gm-Message-State: AOJu0YwfAgqGBcZB9fVkyjx1108hV/CsEPAs2O+o6jvdK1ZAB9YoVxEh
	fTFAkx0yFkP8nJMxIEcz5+B/7meu8dy+Ad7ScAcsRxzht3CLEfh1nMy0hw==
X-Google-Smtp-Source: AGHT+IG+Zl2I3z9KAM8FHKPoo7gpcEmtFKsJKq8sG3rDDt1H9yWLaVBvz0hKOqMk7l8bvUIse3tNsQ==
X-Received: by 2002:a05:6512:318a:b0:52c:e393:6634 with SMTP id 2adb3069b0e04-5343883ba64mr3406459e87.33.1724502216153;
        Sat, 24 Aug 2024 05:23:36 -0700 (PDT)
Received: from ?IPV6:2a02:aa1:1143:b0f6:752:76e9:294d:79b3? ([2a02:aa1:1143:b0f6:752:76e9:294d:79b3])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea88faesm838060e87.263.2024.08.24.05.23.34
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 05:23:35 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------DZf2d90MjjPuLTzdjPmeU1Gz"
Message-ID: <983f5490-ee27-4558-832f-6d5af7344b79@gmail.com>
Date: Sat, 24 Aug 2024 14:23:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cocci@inria.fr
From: Mats Kindahl <mats.kindahl@gmail.com>
Subject: [cocci] Symbolic names in iso-files
Reply-To: Mats Kindahl <mats.kindahl@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1859
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/983f5490-ee27-4558-832f-6d5af7344b79%40gmail.com>

This is a multi-part message in MIME format.
--------------DZf2d90MjjPuLTzdjPmeU1Gz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

In some code, there are macros used for different purposes. One typical 
case is having a "foreach" macro, but this is covered using "iterator" 
so that you can deal with code like this:

    static Jsonb *BuildJsonObject(List *items) {
       ListCell *cell;
       JsonbParseState *state = NULL;
       JsonbValue *value;

       pushJsonbValue(&state, WJB_BEGIN_OBJECT, NULL);
       foreach (cell, items) {
         KVItem *item = (KVItem *)lfirst(cell);
         AddJsonField(&state, item->key, item->value);
       }
       value = pushJsonbValue(&state, WJB_END_OBJECT, NULL);

       return JsonbValueToJsonb(value);
    }

However, if you want to make sure to deal with resource allocation and 
make sure that you release a short-lived lock, for example (grossly 
simplified, just to demonstrate the problem):

    @@
    expression lock, mode;
    @@
       LWLockAcquire(lock, mode);
       ... when exists
    (
       LWLockRelease(lock);
    |
    + LWLockRelease(lock);
       return;
    )

If fails miserably with this code:

    Datum start_worker(PG_FUNCTION_ARGS) {
       pid_t pid;

       if (!autoprewarm)
         ereport(ERROR, (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),
                         errmsg("autoprewarm is disabled")));

       apw_init_shmem();
       LWLockAcquire(&apw_state->lock, LW_EXCLUSIVE);
       pid = apw_state->bgworker_pid;

       if (pid != InvalidPid)
         ereport(ERROR, (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),
                         errmsg("autoprewarm worker is already running
    under PID %d",
                                (int)pid)));

       apw_start_leader_worker();

       PG_RETURN_VOID();
    }

Giving the patch, where the call to LWLockRelease should be before the 
PG_RETURN_VOID:

    --- code/lwlock.c
    +++ /tmp/cocci-output-12611-ff946d-lwlock.c
    @@ -18,6 +18,7 @@ Datum start_worker(PG_FUNCTION_ARGS) {
       apw_start_leader_worker();

       PG_RETURN_VOID();
    +  LWLockRelease(&apw_state->lock);
    }

Since this is such a common construct, and you do not want to deal with 
this for every potential case, this seems like an obvious case for using 
an iso-file, so I created one that looks like this, with the idea that 
we support replacing "PG_RETURN_VOID()" with just a "return".

    Statement
    @ pg_return @
    @@
       PG_RETURN_VOID() => return

However, this fails with the following error message:

    mats@abzu:~/lang/cocci/hacks$ spatch --sp-file lwlock.cocci
    code/lwlock.c
    init_defs_builtins: /usr/lib/coccinelle/standard.h
    iso main: parse error:
      File "./postgres.iso", line 4, column 19, charpos = 46
      around = '=>',
      whole content =   PG_RETURN_VOID() => return

Which I suppose mean that there is no support for handling anything but 
standard tokens in an .iso file.

Have I misunderstood the situation and this is already supported in some 
way?

Are there any plans that add such support to the ISO grammar?

Best wishes,
Mats Kindahl, Timescale

--------------DZf2d90MjjPuLTzdjPmeU1Gz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi all,</p>
    <p>In some code, there are macros used for different purposes. One
      typical case is having a "foreach" macro, but this is covered
      using "iterator" so that you can deal with code like this:</p>
    <blockquote>
      <p>static Jsonb *BuildJsonObject(List *items) {<br>
          ListCell *cell;<br>
          JsonbParseState *state = NULL;<br>
          JsonbValue *value;<br>
        <br>
          pushJsonbValue(&amp;state, WJB_BEGIN_OBJECT, NULL);<br>
          foreach (cell, items) {<br>
            KVItem *item = (KVItem *)lfirst(cell);<br>
            AddJsonField(&amp;state, item-&gt;key, item-&gt;value);<br>
          }<br>
          value = pushJsonbValue(&amp;state, WJB_END_OBJECT, NULL);<br>
        <br>
          return JsonbValueToJsonb(value);<br>
        }<br>
      </p>
    </blockquote>
    <p>However, if you want to make sure to deal with resource
      allocation and make sure that you release a short-lived lock, for
      example (grossly simplified, just to demonstrate the problem):</p>
    <blockquote>
      <p>@@<br>
        expression lock, mode;<br>
        @@<br>
          LWLockAcquire(lock, mode);<br>
          ... when exists<br>
        (<br>
          LWLockRelease(lock);<br>
        |<br>
        + LWLockRelease(lock);<br>
          return;<br>
        )<br>
      </p>
    </blockquote>
    <p>If fails miserably with this code:</p>
    <blockquote>
      <p>Datum start_worker(PG_FUNCTION_ARGS) {<br>
          pid_t pid;<br>
        <br>
          if (!autoprewarm)<br>
            ereport(ERROR,
        (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),<br>
                            errmsg("autoprewarm is disabled")));<br>
        <br>
          apw_init_shmem();<br>
          LWLockAcquire(&amp;apw_state-&gt;lock, LW_EXCLUSIVE);<br>
          pid = apw_state-&gt;bgworker_pid;<br>
        <br>
          if (pid != InvalidPid)<br>
            ereport(ERROR,
        (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),<br>
                            errmsg("autoprewarm worker is already
        running under PID %d",<br>
                                   (int)pid)));<br>
        <br>
          apw_start_leader_worker();<br>
        <br>
          PG_RETURN_VOID();<br>
        }</p>
    </blockquote>
    <p>Giving the patch, where the call to LWLockRelease should be
      before the PG_RETURN_VOID:</p>
    <blockquote>
      <p><span style="font-family:monospace"><span
            style="color:#000000;background-color:#ffffff;">---
            code/lwlock.c
          </span><br>
          +++ /tmp/cocci-output-12611-ff946d-lwlock.c
          <br>
          @@ -18,6 +18,7 @@ Datum start_worker(PG_FUNCTION_ARGS) {
          <br>
            apw_start_leader_worker();
          <br>
           <br>
            PG_RETURN_VOID();
          <br>
          +  LWLockRelease(&amp;apw_state-&gt;lock);
          <br>
          }<br>
        </span></p>
    </blockquote>
    <p>Since this is such a common construct, and you do not want to
      deal with this for every potential case, this seems like an
      obvious case for using an iso-file, so I created one that looks
      like this, with the idea that we support replacing
      "PG_RETURN_VOID()" with just a "return".<br>
    </p>
    <blockquote>
      <p>Statement<br>
        @ pg_return @<br>
        @@<br>
          PG_RETURN_VOID() =&gt; return<br>
      </p>
    </blockquote>
    <p>However, this fails with the following error message:</p>
    <blockquote>
      <p><span style="font-family:monospace"><span
style="font-weight:bold;color:#54ff54;background-color:#ffffff;">mats@abzu</span><span
            style="color:#000000;background-color:#ffffff;">:</span><span
style="font-weight:bold;color:#5454ff;background-color:#ffffff;">~/lang/cocci/hacks</span><span
            style="color:#000000;background-color:#ffffff;">$ spatch
            --sp-file lwlock.cocci code/lwlock.c
          </span><br>
          init_defs_builtins: /usr/lib/coccinelle/standard.h
          <br>
          iso main: parse error:  <br>
           File "./postgres.iso", line 4, column 19, charpos = 46
          <br>
           around = '=&gt;',
          <br>
           whole content =   PG_RETURN_VOID() =&gt; return<br>
        </span></p>
    </blockquote>
    <p>Which I suppose mean that there is no support for handling
      anything but standard tokens in an .iso file.</p>
    <p>Have I misunderstood the situation and this is already supported
      in some way?</p>
    <p>Are there any plans that add such support to the ISO grammar?</p>
    <p>Best wishes,<br>
      Mats Kindahl, Timescale<br>
    </p>
  </body>
</html>

--------------DZf2d90MjjPuLTzdjPmeU1Gz--
