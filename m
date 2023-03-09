Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC52C64EC4
	for <cocci@archiver.kernel.org>; Thu,  9 Mar 2023 10:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vwqxdreMcvdLC/6eq8Yr9L2Ie7B8yxXhODCmXogOyew=;
  b=iRaTxL8XvAYDjlwsKSF0J1PIqpY5Ww6t8UpjJuyo7C/ZQttZ6zL8NLk3
   5wXJWdRh4xWjhYcr7rSszPym1BA5vTnCJApOUT9dHAgeN3CAjzLncja74
   YnHAmJ1mB/obc+M6jQzIaWxEfsG/gRKp7lw4FscMQfkg1Jn7WYGHgNULH
   k=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="5.98,246,1673910000"; 
   d="scan'208";a="96272832"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2023 11:28:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BFF48E00BE; Thu,  9 Mar 2023 11:28:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D5AB0E01A9
	for <cocci@sympa.inria.fr>; Thu,  9 Mar 2023 11:16:17 +0100 (CET)
IronPort-SDR: 6409b1f0_h4mMqxEm4KBux3OHjMG9HPtEJ8JxJa+kRr79bwJtfuZ0K9Q
 lK8z7NLQDAdBP8lcfIr9tflixJ8mr8WupKQSCQQ==
X-IPAS-Result: =?us-ascii?q?A0FwAACisAlkfzbQVdFaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBFGMcl+GATMnAQEBBoFFi1iCE4Qpe4o/gUA+DwEDAQwBQgIEAQEDB?=
 =?us-ascii?q?DiERgKFMgIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBA?=
 =?us-ascii?q?QIQAQEZCRkHDg4FJIVoDYI3KQF1TQM4AQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQQCfjkBAR4BAQECARIoBgEbHQEDDAYFRiMRAQUBH?=
 =?us-ascii?q?AYTIoUEAQMOIwMEphiBBEKLMIEXBQIWgQGCCQacCwoZKA1rgVsCBwkBCBWBG?=
 =?us-ascii?q?QGENyOCaIhzeieBAxWBEIQ/PosDBIMQlAIBAwICAwICAwYEAgICBQQCAQMEA?=
 =?us-ascii?q?g4EDgMBAQICAQECBAgCAgMDAggPEwMHAgEGBQEDAQIGBAIEAQsCBQIKAQIEA?=
 =?us-ascii?q?QICAgEFCQEDAQMBCwICBwIDBQYEAgMNAgEBAwICAg0DAgMCBAEFBQEBEAIGB?=
 =?us-ascii?q?AcBBgMLAgQBBAMBAgUHAwYDAgICAggEEgIDAgIEBQICAgECBAUCBwYCAQICA?=
 =?us-ascii?q?gQCAQMCBAICBAICBAMbAgMFAw4CAgICAQkLAgMHBAIDAwEHAgIMAQMYAwICA?=
 =?us-ascii?q?gICAgEDBwoECQQCBQECAQQLAQUBDQQCAgICAgMCAQEDBggGAwoCBQQDAwYJD?=
 =?us-ascii?q?w8IBQMBBAMCAwIBCAsCAwICBAgCAwECAgEGAgMBAgIBAgIBCwEBAgMFAgIRA?=
 =?us-ascii?q?QICAgICAQECAwIDAQcBAgIcBgQFAwMFAgIBBAECAgQEBQsCBAMBAQECAgICA?=
 =?us-ascii?q?wILAwUDAQYDAwoHBAEIAgYDBAIFBAMEBAYCAgICAgEEAQYLAwIEBAMDBgMJA?=
 =?us-ascii?q?gIMAhQCEgYBBAsLBAECAgIOAwQGAgMDAgIFCQQCAgICAgMGAgkEAgIDAwICA?=
 =?us-ascii?q?wMHAwECAgIFAQQFBgMCBAIBAwIEAgIEAwQBBwICAgICAwECAgMDAQIBBgMCA?=
 =?us-ascii?q?gIFAgIBCAIDAgICAgMDDwEBAQIKAgMBAQEFBAICCAYBAgICBAQBAgICAgICA?=
 =?us-ascii?q?gwDAgICAwICBgMCAgMpDwMDAiADRB0CCQMjDwMLCQgTFygGDAc0BDQBFAcMB?=
 =?us-ascii?q?wcGKg4GAgYDBAEKCwUEBQgBAgEBBgIEAgcJDAIBBgEFAgIDAgEFAgEGAwECA?=
 =?us-ascii?q?gICBQYFAwQFAxMDAQEEAwIBAgECAwIDBwMCBAIDAQIDBAYGAQkEBgUNAwQCA?=
 =?us-ascii?q?gECAQEDBAQEAgIBAgIDAQQCAgEBAwMDAgICAwQCAwMLBAoHAwMCAQULBAIDA?=
 =?us-ascii?q?gMBBgkEAgIGAQIEAgICAgICAwEBAwkEAgEDAgIEAwYCAQIBCQUCAQkDAQIBA?=
 =?us-ascii?q?gEEAQMJAQICBAkCAwcFCgICAgIIAgIOAwMCAQEEAgIEBQkBAgcCBQEBAwUHA?=
 =?us-ascii?q?gIBAgIBBAMBCQQBAgMCAQEDEgMDAQQCBQMDDQkGAgIBAwIBDQMBAgECAwEFB?=
 =?us-ascii?q?RcDCAcUAwUCAgQEAQcCAgMDAwIBAgkGAQMBBQIOAwICBAYBAgEBAgMPBQEBA?=
 =?us-ascii?q?QEXAQMEAgMBBAMBAQIBAgMPBAEEBQsDHAIEAQgIAgIDAwECAwUBAgMEAgEIC?=
 =?us-ascii?q?gICAgIJAgoDAgMBAwUBAwIJAwEFAQIHAgYBAQECAgIGAggCAwsBAwUGAgECA?=
 =?us-ascii?q?gEFAgECAgUDBQICAgIEDQIFAgICBQECBwQCAgIDAQICBgUBAgcHAgUCAgIDA?=
 =?us-ascii?q?woEBAcEAQEBAgEBBQECAQMDAQIEAQIBAgUDBgICAgIBAgIBAQEIAgICAgICA?=
 =?us-ascii?q?wQCCJssgjyUCQGDQItOgTSgSgeDfYQBnGFME5Z0kjaXYqJaH4R1AgoHBhAjE?=
 =?us-ascii?q?oEtOoFcMxojgzdPAxkPjiCDco96QDQ7AgcLAQEDCYVDJhMLAYU7AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:BGqYBKtCzgtbaXLixf0TAcQL7skDW9V00zEX/kB9WHVpmwKj5q
 STdZMgpGLJYVcqKQsdcLW7UpVoLkmslqKdjbNhX4tKGTOWwVdAT7sSlrcKoQeQfREWn9Q1vc
 wBT0E9MqyJMbETt6fHCWKDYrEdKbe8gcWVbCTlo0uFjzsGV0it1WhE48+gfHFLeA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,246,1673910000"; 
   d="scan'208";a="49666682"
X-MGA-submission: =?us-ascii?q?MDGRFhrXkd/eHpoBcOvEZmP3qSAGKze7G+HHDf?=
 =?us-ascii?q?UZqVsEyn79TX9OvJuVFhcM4D6+P6dWgPT4tsxZMFfVDyJWwoVdJvVWBF?=
 =?us-ascii?q?axkpim890h/bZFBvJGOipM+5cBSRNW8bQqzgCUNQJI02h8HOPb0riZjH?=
 =?us-ascii?q?9MqGA2y1N90Y4cftbc5s429Q=3D=3D?=
Received: from mail-ed1-f54.google.com ([209.85.208.54])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 11:16:18 +0100
Received: by mail-ed1-f54.google.com with SMTP id o12so4815871edb.9;
        Thu, 09 Mar 2023 02:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678356976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwqxdreMcvdLC/6eq8Yr9L2Ie7B8yxXhODCmXogOyew=;
        b=RAsbW6kHmZF/sMhTIhD0wMuqhmgC9e+YX2pGl3ghQpxecchnmIKsAk71hs31j4GFsg
         er3R9seezm37jruBFSXZ8FF3k6ff16CchDrV65PEJFsW9ynqu7pz+8HdLfgL7PvvgrI6
         i9HzImK91yHtbRGmOst6KZvVIvGdWC6u9BUB0k7xh8/e706BD91S3wPZ9jpzd4YDOWnt
         9UNpqGlj/O8hDpECYZdTGLdv9faRxP68ln6uAym/bZshnoRA/1yq8/cbzSC928l2b5yA
         vyuFQjhah33t9NEgpBJj4z3mgfUAML+gpNhY5q96qyiH7lA030PH3EReAIySt/4P5d9b
         iEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678356976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwqxdreMcvdLC/6eq8Yr9L2Ie7B8yxXhODCmXogOyew=;
        b=vq5YejiVw4PmkhM30d0Aoi/XCH3qQ+7ZJbQNtDzYa+a3u67TcgDNYRIrx1cf4TVbPN
         FqtfKzmOkngghCFs8iEZTGcdAqLHWdJ4h1DPX4+8qBXbJfes5VYTfci3pu9ADS5DL6NN
         qW+xyAHROIQc/4XkkzI/G/LF/gaBhTwewmpgCUnLJoKi5wRxgrh6WXm/FW27ptuydenn
         52416JJNo8svg5YlK2NFiqbwgrmxYu+STud7njxHDl+++1hJTuHqF1h9YlkWVfS2Zkwi
         gfEKIVUvLOopWjITLlrSrNO4v8C4y+KJDCSjpcYhzTmcJX9aGj8717U9VHQiHTH32E7U
         bdEA==
X-Gm-Message-State: AO0yUKXuAPcwzUBzJgHCsCuxg3MH9UN7DPY7FB9lzPysvVEGlG7WDlil
	gpkVrJXfRG3uMYb73oIFhQMKobDS1cI=
X-Google-Smtp-Source: AK7set95v3KTl3k7BUIckHPOKqWMQ5zUFWV37lMjFs4qhMDtT1OEdMZ9h/v8KT4nTtF3OcpNKegzmw==
X-Received: by 2002:aa7:d6d0:0:b0:4ae:eb17:3afc with SMTP id x16-20020aa7d6d0000000b004aeeb173afcmr16623547edr.7.1678356976080;
        Thu, 09 Mar 2023 02:16:16 -0800 (PST)
Received: from nbbrfq (80-110-214-113.static.upcbusiness.at. [80.110.214.113])
        by smtp.gmail.com with ESMTPSA id j23-20020a170906255700b008d9c518a318sm8776586ejb.142.2023.03.09.02.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 02:16:15 -0800 (PST)
Date: Thu, 9 Mar 2023 11:15:41 +0100
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: rep.dot.nop@gmail.com, cocci@inria.fr
Message-ID: <20230309111541.4bd397f5@nbbrfq>
In-Reply-To: <95103e65-6f5a-ae64-8ab2-7c57e5ca9438@inria.fr>
References: <20230309092812.71b25d5c@nbbrfq>
	<89959f1e-b5ed-6b2c-2931-4fdd65428e89@inria.fr>
	<ad666bb2-3f4-47a2-13fd-8f7e29b8af79@inria.fr>
	<20230309101001.78c0bc26@nbbrfq>
	<95103e65-6f5a-ae64-8ab2-7c57e5ca9438@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] HELP: multiple inserts at one position
Reply-To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 885
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/20230309111541.4bd397f5%40nbbrfq>

On Thu, 9 Mar 2023 10:38:50 +0100 (CET)
Julia Lawall <julia.lawall@inria.fr> wrote:

> > Now, mere cosmetics, but is there a way to retain the spaces before the
> > braces in the replacement?
> 
> Try the argument --smpl-spacing.

That does the trick, thanks!

Is there a way to use regexp captures for the matching and replacement
part? Think templates for (parts of) the name of the identifiers.

In the specific case of mpz and mpfr, both use a similar API for the
allocators {mpfr,mpz}_init{,2,3,_set_str} and deallocators
{mpfr,mpz}_clear{,s}

To avoid duplicating the rules for "mpfr" and "mpz", it would be handy
to match and replace per the underlying type or, maybe, a part of the
matched identifier name. Is that something that is readily available?

Just curious, it's not all that important..

thanks for your prompt help so far!
