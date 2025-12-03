Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F622D1CDC6
	for <cocci@archiver.kernel.org>; Tue,  9 Dec 2025 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=sender:date:from:to:cc:message-id:references:
   mime-version:in-reply-to:subject:reply-to:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=FRfy5QGmIZODbekP4ivkGvjisPnPRYoUT+9cD5HVv3M=;
  b=ZFglGcsXOdHElTLJz92NGhcjA6aKDnB06UdnMLlicyujBp7zEaPUGX9J
   LD6qss7ke2rRfSYAvqpdjya14yd01isMzFOC6SDoGtQTkPGPsE8zbQvM1
   /lWBelcC2fBoDO02nxnXl8RMxOTQ1F+iTUgXtYMxx6BbOiU2Rl1SI6TBr
   E=;
X-CSE-ConnectionGUID: K1KWiJ/+QCag+KP+tDcUmA==
X-CSE-MsgGUID: 25NIVv6sQaiquzhzLTluVw==
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
X-IronPort-AV: E=Sophos;i="6.20,261,1758578400"; 
   d="scan'208";a="253495136"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2025 11:10:04 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 76C2AE00A5; Tue,  9 Dec 2025 11:10:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 12AC4E00A5
	for <cocci@sympa.inria.fr>; Wed,  3 Dec 2025 04:34:25 +0100 (CET)
X-CSE-ConnectionGUID: L6kvbjSfSPGnDPJ96vK4/g==
X-CSE-MsgGUID: c6yIBy6xTqa6cX01dY1xwQ==
IronPort-SDR: 692fafc1_3rhJ3qUYzow06PMVcxu6Dh9kM3R0l7RcPDq3zSZTuMCcU8l
 hotizzEaA3wIktM44a+IIP4dORptS77N7RZYt4g==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FcAgCori9pgbDXVdFaHgEBCxIMQIFFC4FuUoFhMwRUl?=
 =?us-ascii?q?CiCJJg8hx49EQEDAQsBAVEEAQEDBJFpAh4HAQQzBg4BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBDQEBBQEBAQIBAQIEBgECEAEBIhkHDjuGTw2CYgGBJGECBQM7AQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQIsXwEFEigGATgBA?=
 =?us-ascii?q?wwBBQUYLjMBBQEcBhMigmCCIwEGEQM2AwGlAYEFQos8gTSBAYINBtsFKA2CU?=
 =?us-ascii?q?gIHCQEKgTeIUwGFboN+eicbgg2BPIMDPosHBIIigQ6GIotmh1lSeHgsAVUTF?=
 =?us-ascii?q?wsHBYEgQwOBCyNLBS0dgSMhHRgTYFRAg0kYBmcPBoERGUkCAgIFAkA6gWYGH?=
 =?us-ascii?q?AYcEgIDAQICOlUMgXcCAgSCFn2CCg+IAQGBCwUufSUCAQttPTcJCxsGlVNPg?=
 =?us-ascii?q?jOBKZkfjxGhDoQminyWYAZCg3EBk2CTGS6HZZBzqRUCCgcHESSBWiSBXDMaC?=
 =?us-ascii?q?CYKgyJPAxkPMY1wDBaDXr0IIjU8AgcLAQEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
 Fg5jQxxZelr/zDpsQ9fGw==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:HIMH1aArYaEUxMblHelX55DYdb4zR+YMi2TDGXoBMCC9Vvbo6P
 xG/c5rqSMc7Qx6ZJhOo6HlBEDtewK6yXcx2/huAV7AZniahILLFvAY0WKK+VSJcFydygce79
 YbT0EXMqySMbFUt7ee3ODSKadZ/DDoytHPuc7ui1hqVh9jcKxt4kNUDQyBAlRqSAQuP/YEPa
 vZyM4CiTTIQxoqhweAaUXtndKvmzQGrvPbiNc9ZyIa1A==
X-Talos-CUID: 9a23:NB1zkG0M1jaFmRDy2lYff7xfPp4mbHff93nrG2C+JV5LGeOLagPX9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AKe8mCgyVTRMYx03yU6QdT7ASHjOaqK/wGWEngMs?=
 =?us-ascii?q?Wh9CNaydAY26RvW2nXbZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,244,1758578400"; 
   d="scan'208";a="252451136"
X-MGA-submission: =?us-ascii?q?MDFVl194dIkmU0oX6yvR+uX+kOlZp3cZ+xxl6Y?=
 =?us-ascii?q?Og+2geSiCkh9qB/0ipyK4hQlngSGws1qqlXcDrSlHYhpjpeO8zEpJa+g?=
 =?us-ascii?q?9sYHOi89y+gDYnII2V2GtV8/L9OshiZ+oM8XZNvQEEtKRIgVO2iIJ6HH?=
 =?us-ascii?q?4Imdwc+w4mvi6uHEot2V8Vrg=3D=3D?=
Received: from mail-pg1-f176.google.com ([209.85.215.176])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 04:34:24 +0100
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bf1b402fa3cso1349630a12.3
        for <cocci@inria.fr>; Tue, 02 Dec 2025 19:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764732863; x=1765337663; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRfy5QGmIZODbekP4ivkGvjisPnPRYoUT+9cD5HVv3M=;
        b=IjsAKBYWgYEtm3MqQhlStDyWGR/Pc9K94sgQ/DBVIx0/eWYmsRQPFrVNDDK3EP9StW
         2RqkI1A3XD3B0qLW12PsVdoOK242UjfUkgfjJ2FaGpNWPzZzDEB4BVMA90V8uLdQ2w/5
         DVXRkl8Y0wSV3X/4JLm9vqXo6cX4khBVdWaHWexvcbgAisPqAbOlGDOn7jrDc6Q2dtj0
         xtl82a4cAOsyD++kg1d5xNXnDnTq/B33EyvWckjL3kTfjPgn/0P+28onuTZzQw+42vSY
         KmiiidO1s57fIdQ+fJiIiADLVORKjI8idHKhBz6x/j5NP1mHTuwa24F6WHlg3CqVvP5E
         lb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764732863; x=1765337663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FRfy5QGmIZODbekP4ivkGvjisPnPRYoUT+9cD5HVv3M=;
        b=PCg8Jdu+aN2VMqu33RBoG8oYvqHQbe9p/2p0RLrn47sSC7an98VDwYKAjmqL0TkP0h
         esD5iqKgvPSYArgLVAioq7uH3t3sv64Q6CjPJnbxMw9mM15ZCpiLdM5kaqs2fIKFEx5E
         qR/gqPrn+FV1XF1DgRDM3LDx9dGw6HHnsTCo9fkvBqSG7EzdadP605cDZ40fHRzPp30F
         7+OJ8lyZABUm6+67kixpp0vIKtH+gosLz8sdkIv5IUiRvBc5/VaBk9777WLZzOZO5re4
         nBshUtDJxEoMua5OgKnqEokYNkgkq2tzKShmjdnIs8Bw20vllu0LOc+IQ8461tHZR/Pi
         i6IA==
X-Forwarded-Encrypted: i=1; AJvYcCXDp5tPhfk4/It5k/+YqxPdSIcJbFqZjeATMPxw+JaMC4QxKi4vovkvkwqE8lVFufi1iP5mDQ==@inria.fr
X-Gm-Message-State: AOJu0YyMBOHt7OA7rycalET0FgI8rD09TDEcDwotoUC0xWAF3PGYqUn+
	NxM+ff7saptmoa/1ITnxtROYQgtaM8a01B56f+XFJkt7SAoSqc/1+hzD
X-Gm-Gg: ASbGncuWacXV/evq3Q0PhtHgokAVZGMQhg5MIlJD2Un+/b0PDsO8ga1w6eZxU5FGcFQ
	WhHfFWzTna6KpzJsuaeYvAmktT+5tIwZRdaRrboD2Rea9hZhfqSvXhYqHzTbqk7SRxwpivNJbxj
	AGoCmDNgllJ7DYwXfLOU4dTKr+hkrcpGZJBrfxYYPfOyKnqPJkJ6oonD/uJg46t3VnDThpwplJ3
	B+YhGNUMYkIoFtNDQ5juOHRdrcYnBo3Ix2dI9EIqq5E1C11Ef0xXDWmnHrk+SesItRqtMmYPqVz
	16hu9yUk6CirgEoRrOfrdjJlZMeOtdEPBzvKPK4hmIqhpHOelLRS/rG6s3hXC+KTit2w0cDwUV0
	/9qEYSbFz+2//9awpnEN7hpOO98A1gbzvJaqEp7qPnrZHhFuGTn2NkDNniQtlenFIy+CqT5N2h9
	24DvDx7wtara7Xyac8aWfXvSM=
X-Google-Smtp-Source: AGHT+IFxMzxQO6KofdGARUR6oYWbgoTNRcXyxWohQhQ68B7N5GSHLnrgZCmxirt4iBUacrPv/L/unQ==
X-Received: by 2002:a05:693c:2483:b0:2a4:5a26:25e1 with SMTP id 5a478bee46e88-2ab92e816d4mr474100eec.30.1764732862761;
        Tue, 02 Dec 2025 19:34:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a9653ca11esm60182255eec.0.2025.12.02.19.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 19:34:22 -0800 (PST)
Sender: cocci-request@inria.fr
Date: Tue, 2 Dec 2025 19:34:21 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-pm@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>, linux-kernel@vger.kernel.org,
	cocci@inria.fr
Message-ID: <a63bb78f-ec2b-4e6e-9d8a-be00cb2a6c17@roeck-us.net>
References: <20251202193129.1411419-1-briannorris@chromium.org>
 <20251202193129.1411419-2-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202193129.1411419-2-briannorris@chromium.org>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 2/3] PM: runtime: Make pm_runtime_barrier()
 return void
Reply-To: Guenter Roeck <linux@roeck-us.net>
X-Loop: cocci@inria.fr
X-Sequence: 3254
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/a63bb78f-ec2b-4e6e-9d8a-be00cb2a6c17%40roeck-us.net>

On Tue, Dec 02, 2025 at 11:30:25AM -0800, Brian Norris wrote:
> No callers check the return code, and that's a good thing. Doing so
> would be racy and unhelpful.
> 
> Drop the return code entirely, so we don't make anyone think about its
> complexities.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>
