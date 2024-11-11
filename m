Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9142CD3ABF5
	for <cocci@archiver.kernel.org>; Mon, 11 Nov 2024 20:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7UPQBap+nl1GoyYxVchPYI+CIlbRHhYg9tnoptTl39s=;
  b=j9+Cjask8m23e7wEOv2FIVPq/SvxcU/OM3CvVQhfEAwXbYhZwgPEWjxr
   e+M31iu0Iu5zjgWVQ7R6S0lciC9WP5Aesy1/wlUOzu2yJ5xDi5UyOO/ka
   f/x4PDylBD3HWOaixtO7QNq2W5ZTd1Hmwg6b6PVw/RU1I2Uga9/tylbT3
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="6.12,146,1728943200"; 
   d="scan'208,217";a="193213394"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Nov 2024 20:59:59 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ED7F8E0D1C; Mon, 11 Nov 2024 20:59:58 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0F340E00B7
	for <cocci@sympa.inria.fr>; Mon, 11 Nov 2024 20:59:58 +0100 (CET)
IronPort-SDR: 6732623d_0OZ+geqryf2E5QTbD5B9f9DybWvlTC5OT26kzKHgCfxZpIX
 Qba6OFl+gIl706g+wUNaRj4Tobl6wJ+ZxleLl5Q==
X-IPAS-Result: =?us-ascii?q?A0HTBADmYDJnfLPQVdFaglyBclKBVzMEU4RWj02BdIRrh?=
 =?us-ascii?q?zqLS4ZVgUA+DwEDAQwBQgIEAQEDBDcBjwUCHgcBBDIHDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEQAQEFAQEBAgEBAgQGAQIQAQEiGQcOEimFew2CW4EsYQIFAzsBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAix3EQQZARseAxIQN?=
 =?us-ascii?q?wIkEQEFATcBAR6CX4IwAQMxAwGkOYEFQos+fxYFAhaBAYINBoJp13MKGSgNb?=
 =?us-ascii?q?AOBYQIHCQEKgTSEcylODoI3HQEqgTICiAiBIQ+BVUSBPIJSAQGJC4JpBIJDf?=
 =?us-ascii?q?DqCcHYliRWHO4NAjV4IBx8SCRwGCgJLBRASAwQDBAQBAgsJCgkDAwIOAggDA?=
 =?us-ascii?q?ggGHwE/EgQTCg0LBwUfCgcMEQooBCITLxADMgMEBQMFAwMEBwECBQQJCAEFA?=
 =?us-ascii?q?wIEAwMCAgMCCAUHBAMKBgEBAwQDAQEFBwcDAgEBAwEBCgsIDQUDCAMGCQMEA?=
 =?us-ascii?q?QEFFQIDDgICAgMCAQoGCAUBAwYhAQwDAQMDBQwEFAMEBQICDwwBAgMDBwMFA?=
 =?us-ascii?q?gICAgICAgUEAQIEAgQBCAQJAQICAgMCAQEGBAICAgMCBwwHAwQCBgIGAgMCB?=
 =?us-ascii?q?wsKAgMGBQUDBQIeAgMCAgQDAxUBBAECAQIDAgIDAgMEAQMDAgEBAQMHAgICB?=
 =?us-ascii?q?wYFAgIDDAIDAwEBBgECAQIPBQUGBAEKAwIUAwUiAg8FCAEmAS0CAgMEDQgFA?=
 =?us-ascii?q?gIHAgQMAgQPBQMDDgYWBgEECAQGBAwKAwQOBxcRAQEEBAITBwILAgIGBAICB?=
 =?us-ascii?q?yMGAwUIAwIFBRACAgsCBAMVBAQbAwECCAICGAIBBwECEgEHBAEUAgoDAgUGB?=
 =?us-ascii?q?wIcAgIDAwQEAwEFAwQQAwsBBQYFAQEEDgECAQIBAQIDAw4BAgIGAgIBCQICA?=
 =?us-ascii?q?QECDQgBBAMIAgUDBQMKAQEBAgEECQQPBgMFAwMHAwQCAwIGAgQEBAICAwMCA?=
 =?us-ascii?q?wEDAwIBAgMJAgEPDwoPAgIDBAIGAgIBBCYCARUFAgMEAgIHAgIDAQIBAgICB?=
 =?us-ascii?q?AIEAgIGAwkIAQICBwECAgIDFQIFAQQJAwMFEgwiAwMBAgICAwcKAwUCAQECB?=
 =?us-ascii?q?AMDAwMJDQcCAwECAQMFAwECAQIJAwYCAgMDBRIZBQMCDwMCAQUEAggSCwcBA?=
 =?us-ascii?q?Q8WBQQJBRUDBgIDAxYLBAUDAwMBDAUMDgICCwMXBQEBBwEDDggDBAQCAwMJA?=
 =?us-ascii?q?gEQAQMEAgkCBAECCgICAgICBAEBBQQCBAMCBQICAQgEAwMDDQQDCAgDBQMME?=
 =?us-ascii?q?gICAgkCAwECAwMDBA0IFg0DAg0aChUTBwcDAwQLAgkDBA0CBAICAQYDBgoGB?=
 =?us-ascii?q?wQFBgECGAICBgwEAwMIAwIDAgIBAgICARECAgkIDQUJBQYCFgMCAwgBCQMPA?=
 =?us-ascii?q?wIUAQYCCAMHAQEEAgIKEQoBAQICAQcsAwEBAhQUBwMIAgICAgYWDAEFBwMHD?=
 =?us-ascii?q?wUFBAICFgMDFQQEDAcCAgMDAgEBFAgVAQUCAwYLAQYBAgUEAgMEAhQCEgMEA?=
 =?us-ascii?q?woCDwMGAwQGAwECDBACBAIJCwEFBAMHBQIfAwMCAgULAggCAgUCBQcDCQsGA?=
 =?us-ascii?q?QIIAwQJAhQCEAICAgIIFAcCAgICBR4DJgIEAwMDAwsBAgIOCQZFBhMEAgMDA?=
 =?us-ascii?q?g4BAgILAQICBAIDAQQHCQMDCQoHAQoNBwICCggJEAECAg8HAwICAgIGBxEDA?=
 =?us-ascii?q?hMPBQYGAgoHDQoDAgECAhUCAwkGAwUNAwcECg8CFwIYBQMhAggJCwIQHQIJA?=
 =?us-ascii?q?yMPAgELCQgTPQwHMgQ0AQkLFAcGJYEAnR8BCoFihCkTgktYklqLIIg4nxg0B?=
 =?us-ascii?q?4QdBYFYBgyfVQYPBC+XP5MOmHeoeQIKBwYRIxKBOQQvgVwzGiOBAYI2TwMZD?=
 =?us-ascii?q?44tFoNYxWBCNTsCBwEKAQEDCYVpiWCBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 vlALkXS3Hi4FX0=
IronPort-HdrOrdr: A9a23:c4bA0aDPhC3zR9zlHeiXsseALOsnbusQ8zAXPh9KJCC9I/bzqy
 nxpp8mPEfP+U8ssQIb6Ki90ci7MDvhHPFOkOws1NuZMjUO/VHYSr2KjrGSiAEIeReOktK1vJ
 0IG8QQNDSzNykcsS+Q2mmF+qMbsbu6GdeT9ITjJhlWLD1CWuVF1UNUGwybGkp5SE1vAoc4Lo
 OV4o5qtietYnMea+W8Hz0gU/LYr9PGuZr6aVpebiRXpTWmvHeN0vrXAhKY1hARX3dmxqojy3
 HMl0jU97iuqPayzz7bziv2445NkNXs59NfDIini9QTKB/rlgG0Db4REYGqjXQQmqWC+VwqmN
 7Dr1MLJMJo8U7ceWmzvF/ExxTg+CxG0Q6s9XaoxV/Y5eDpTjMzDMRMwahDdAHC1kYmtNZglI
 pWwmOisYZNBx+oplWy2zGIbWAqqqOHmwtgrQchtQ0cbWLYUs4VkWUrxjIULH7HJlO/1GloKp
 goMCiW3ocsTbrTVQGigoAo+q3hYp17JGb7fmES/sOSyDRYh3Z/0g8Rw9EehG4J8NYnR4BD/P
 msCNUeqFhidL5iUUtGPpZ0feKnTmjWBR7cOmObJlrqUKkBJnLWspbypLE4/vujdpAExIY73M
 2paiIQiUciP0b1TcGe1pxC9R7ABG27QDT208lbo5x0oKf1SrbnOTCKDFouj8yjqfMCBdCzYY
 fEBLtGR/v4aWf+E4dA2APzH5FUNHkFScUQ/s02Xlqfy/i7WLECdtarA8o7CICdYArMAFmPfU
 crTXz2PoFa4kigR3//hwK5YQKRRqXWx+MPLIHKu+4O1YMKKopA9gAIlFXR3LD6FQF/
X-Talos-CUID: =?us-ascii?q?9a23=3A687Zwmkl48OnTGw4/JCS4VpjWcPXOXKG7S/+HWu?=
 =?us-ascii?q?WMns3ZYWNSXSho6I+zdU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A2LKMHw9vQwSs4sIFpvj06bKQf5dQzZSzM34OrYc?=
 =?us-ascii?q?LkfnVFDZLHSWQtQ3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,146,1728943200"; 
   d="scan'208,217";a="193213393"
X-MGA-submission: =?us-ascii?q?MDHrK2URrmcE7kOF/Gb1kBLS/jSc1QhCJ5Fqi9?=
 =?us-ascii?q?s1vOTzNsfd7GBDjPFPBSkViakEcNyw/h9DVXi8V8f4enE7MvRK3hpmfk?=
 =?us-ascii?q?3I1EratsonXuSz3CvRrKSAVkokoHwmOPfDGl2S0lqAhd2+E7XnTg8wnk?=
 =?us-ascii?q?A/TUc1DhELWYIaTEOjPurc3Q=3D=3D?=
Received: from mail-lj1-f179.google.com ([209.85.208.179])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 20:59:57 +0100
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so40513271fa.1
        for <cocci@inria.fr>; Mon, 11 Nov 2024 11:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731355196; x=1731959996; darn=inria.fr;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7UPQBap+nl1GoyYxVchPYI+CIlbRHhYg9tnoptTl39s=;
        b=HyemFt2B1AWpK79Rx8pDJY641eG5/rjXy3W8txWRtRifhz4p+x9tK8ulC81SBSPEVa
         CJsSFBjwd4MH+37UTXPhhmdcmKK43HtcSIQBdAhKMgI3MXCjVvPGbxfVK3BdvPsLNzB4
         PJLFO0QXB3B5mSCiW4VKCnoMViWrbhzGcX3ku0/EHDuJ+5p88Qje4CcVa4pb4ikwxB5I
         TSIx9H4NmUsIzGeDXz0cXRMIQu2shlsmahV8lFykR81yuiM5cNFqoH8rzSps2sgOfHSf
         83o/lKaBicvk8r/4mlPWuOBe5PKIOgFhAt57YB/OpgQBc/qTQQROdjIQXiR43azD6mCc
         zcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731355196; x=1731959996;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7UPQBap+nl1GoyYxVchPYI+CIlbRHhYg9tnoptTl39s=;
        b=Dh9G+M/2DeyprxIRViwrmPXn+E+vehZMOZ/8p4WEMJ8fgR/JdQVPn+DvnsRChdqirI
         0s8/1K695cAUDscE+ri2QSHYEkylNUQTenOE8r3uyGRZaouTusvnqleQRkDMHgfaMs0l
         mXQVr378vukzCAPm0s56md/ZvkEPD+T8DK+8Z6AqXFyuLKhw2IoKJBcIlBodwyEWOk3F
         I8gB1bgR4k30I0cf4FOLeITnPtYOhD1rZkeQ9O6WhnXGft7SAAk6pKqNAanRHdqo/Arw
         +wnvSmd6V3fjQSI9fjF4BK4DkvefMISTcDIskVEXmYffuhxV7RGTcixdtJ/Jnq8Fy0xd
         iEmw==
X-Gm-Message-State: AOJu0YwrHWZ0z++AVk4htwXrlgjuobCqZXbIQidoqxSN1BHfP86cevrM
	T5PK9+NSKeY1UQQlThYN9+myRUU1V4d/4awlslWXvjJ+rtUKKg9d4e0KJg==
X-Google-Smtp-Source: AGHT+IEIvpq/mNqsnQQCR1kwzGNcenaVEJUG9RzfDeIPO/I35lwBDZwirxt+zWgHxkveOdt0e4z48A==
X-Received: by 2002:a05:651c:b06:b0:2fa:cc86:f217 with SMTP id 38308e7fff4ca-2ff20307f42mr68900491fa.35.1731355195998;
        Mon, 11 Nov 2024 11:59:55 -0800 (PST)
Received: from ?IPV6:2a02:aa1:1656:81ae:f3c5:f1ae:f3ca:84e6? ([2a02:aa1:1656:81ae:f3c5:f1ae:f3ca:84e6])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff178dfe0asm17862501fa.23.2024.11.11.11.59.53
        for <cocci@inria.fr>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 11:59:54 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------9Ad6jrwHuWl9Qnu60pZ4auL5"
Message-ID: <f59fb941-f9a9-455c-a369-f764e33323e8@gmail.com>
Date: Mon, 11 Nov 2024 20:59:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: cocci@inria.fr
From: Mats Kindahl <mats.kindahl@gmail.com>
Subject: [cocci] How to add error handling code before first use
Reply-To: Mats Kindahl <mats.kindahl@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 1994
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/f59fb941-f9a9-455c-a369-f764e33323e8%40gmail.com>

This is a multi-part message in MIME format.
--------------9Ad6jrwHuWl9Qnu60pZ4auL5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi again,

I am trying to match code like the following and add error handling to it:

    #include <postgres.h>

    void foo(Oid id) {
       HeapTuple tuple;
       Form_pg_proc fd;

       tuple = SearchSysCache1(PROCOID, ObjectIdGetDatum(id));
       fd = (Form_pg_proc)GETSTRUCT(tuple);

       if (strcmp("magic", NameStr(fd->proname)) != 0)
         printf("Bad magic\n");
    }

The semantic patch I have for this is:

    @@
    identifier tuple;
    expression id, cache;
    statement S;
    @@
       tuple = SearchSysCache1(cache, ObjectIdGetDatum(id));
       ... when != tuple
    (
       if (<+... HeapTupleIsValid(tuple) ...+>) S
    |
    + if (!HeapTupleIsValid(tuple))
    +   elog(ERROR, "cache lookup failed for %u", id);
       (<+...tuple...+>);
    )

However, when executing spatch, I get the following error:

    mats@abzu:~/lang/cocci/postgres$ spatch --all-includes --sp-file
    heap_tuple.cocci code/heap_tuple.c
    init_defs_builtins: /usr/lib/coccinelle/standard.h
    before [[Tag29 ("{", 0)]; [Tag22 ((Tag1 ((Tag5 (("if", (11, 2, 0, 0,
    " "), Tag2 (0), 0), ("(", (11, 5, 0, 0, " "), Tag2 (0), 0), (Tag9
    ((Tag3 (((
    ((("HeapTupleIsValid", (11, 7, 0, 0, ""), Tag2 (0), 0)), 11, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 1, 0),
    ("(", (11, 23, 0, 0, ""), Tag2 (0), 0), ([(((Tag1 ((("rule starting
    on line 1", "tuple"), (11, 24, 0, 0, ""), Tag2 (0), 0), 1, 0, 0),
    11, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 1, 0)], 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (")", (11,
    29, 0, 0,
    ""), Tag2 (0), 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (6,
    (11, 6, 0, 0, ""), Tag2 (0), 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 1, 0),
    (")", (11, 30, 0, 0, ""), Tag2 (0), 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 1, 0), (Tag8 ((Tag4 (((Tag3 (((((("elog", (12, 4, 0, 0, "
       "), Ta
    g2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 12, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), ("(", (12, 8, 0, 0, ""), Tag2 (0),
    0), ([((
    ((("ERROR", (12, 9, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 1, 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
    (Tag26 (("
    ,", (12, 14, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 1, 0); (Tag1 ((("cache lookup failed for %u", 4), (12, 16,
    0, 0, " ")
    , Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0); (Tag26
    ((",", (12, 44, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0
    , 1, 0); (Tag22 ((("rule starting on line 1", "id"), (12, 46, 0, 0,
    " "), Tag2 (0), 0), 1, 0, 0, 0, 0, 0), 12, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 1
    , 0)], 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (")", (12, 48, 0,
    0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)),
    (";", (1
    2, 49, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 1, 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (0, 0, 0,
    Tag1 (0, 0)))
    , 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0))]]
    context tree should not have bad code before

First, what is causing the error?

Second, is the semantic patch supposed to work or is another method 
preferred?

Best wishes,
Mats Kindahl

--------------9Ad6jrwHuWl9Qnu60pZ4auL5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi again,</p>
    <p>I am trying to match code like the following and add error
      handling to it:</p>
    <blockquote>
      <p><font face="monospace">#include &lt;postgres.h&gt;<br>
          <br>
          void foo(Oid id) {<br>
            HeapTuple tuple;<br>
            Form_pg_proc fd;<br>
          <br>
            tuple = SearchSysCache1(PROCOID, ObjectIdGetDatum(id));<br>
            fd = (Form_pg_proc)GETSTRUCT(tuple);<br>
          <br>
            if (strcmp("magic", NameStr(fd-&gt;proname)) != 0)<br>
              printf("Bad magic\n");<br>
          }</font><br>
      </p>
    </blockquote>
    <p>The semantic patch I have for this is:</p>
    <blockquote>
      <p><font face="monospace">@@<br>
          identifier tuple;<br>
          expression id, cache;<br>
          statement S;<br>
          @@<br>
            tuple = SearchSysCache1(cache, ObjectIdGetDatum(id));<br>
            ... when != tuple<br>
          (<br>
            if (&lt;+... HeapTupleIsValid(tuple) ...+&gt;) S<br>
          |<br>
          + if (!HeapTupleIsValid(tuple))<br>
          +   elog(ERROR, "cache lookup failed for %u", id);<br>
            (&lt;+...tuple...+&gt;);<br>
          )</font><br>
      </p>
    </blockquote>
    <p>However, when executing spatch, I get the following error:</p>
    <blockquote>
      <p><span style="font-family:monospace"><span
style="font-weight:bold;color:#54ff54;background-color:#ffffff;">mats@abzu</span><span
            style="color:#000000;background-color:#ffffff;">:</span><span
style="font-weight:bold;color:#5454ff;background-color:#ffffff;">~/lang/cocci/postgres</span><span
            style="color:#000000;background-color:#ffffff;">$ spatch
            --all-includes --sp-file heap_tuple.cocci code/heap_tuple.c
          </span><br>
          init_defs_builtins: /usr/lib/coccinelle/standard.h
          <br>
          before [[Tag29 ("{", 0)]; [Tag22 ((Tag1 ((Tag5 (("if", (11, 2,
          0, 0, " "), Tag2 (0), 0), ("(", (11, 5, 0, 0, " "), Tag2 (0),
          0), (Tag9 ((Tag3 (((<br>
          ((("HeapTupleIsValid", (11, 7, 0, 0, ""), Tag2 (0), 0)), 11,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 11, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 1, 0),<br>
          ("(", (11, 23, 0, 0, ""), Tag2 (0), 0), ([(((Tag1 ((("rule
          starting on line 1", "tuple"), (11, 24, 0, 0, ""), Tag2 (0),
          0), 1, 0, 0), 11, 0, 0, <br>
          0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 1, 0)], 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
          (")", (11, 29, 0, 0, <br>
          ""), Tag2 (0), 0)), 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
          0), (6, (11, 6, 0, 0, ""), Tag2 (0), 0)), 11, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 1, 0),<br>
          (")", (11, 30, 0, 0, ""), Tag2 (0), 0)), 11, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 1, 0), (Tag8 ((Tag4 (((Tag3 (((((("elog", (12,
          4, 0, 0, "   "), Ta<br>
          g2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), 12,
          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), ("(", (12, 8, 0, 0,
          ""), Tag2 (0), 0), ([((<br>
          ((("ERROR", (12, 9, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 1, 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 1, 0); (Tag26 (("<br>
          ,", (12, 14, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 1, 0); (Tag1 ((("cache lookup failed for %u",
          4), (12, 16, 0, 0, " ")<br>
          , Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
          (Tag26 ((",", (12, 44, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0<br>
          , 1, 0); (Tag22 ((("rule starting on line 1", "id"), (12, 46,
          0, 0, " "), Tag2 (0), 0), 1, 0, 0, 0, 0, 0), 12, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 1<br>
          , 0)], 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0), (")", (12,
          48, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 1, 0)), (";", (1<br>
          2, 49, 0, 0, ""), Tag2 (0), 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 1, 0)), 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0),
          (0, 0, 0, Tag1 (0, 0)))<br>
          , 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0))]]
          <br>
          context tree should not have bad code before<br>
        </span></p>
    </blockquote>
    <p>First, what is causing the error?</p>
    <p>Second, is the semantic patch supposed to work or is another
      method preferred?</p>
    <p>Best wishes,<br>
      Mats Kindahl<br>
    </p>
  </body>
</html>

--------------9Ad6jrwHuWl9Qnu60pZ4auL5--
