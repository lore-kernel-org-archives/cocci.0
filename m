Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78029D3B7F8
	for <cocci@archiver.kernel.org>; Tue,  9 Dec 2025 10:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=sender:date:from:to:cc:message-id:references:
   mime-version:in-reply-to:subject:reply-to:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=uN4c8sU/S8sKfqIqWSZ2ukImvsU3t4AIDPSRgGg4a6o=;
  b=aaRPa7XP6iBEQaRNhB7YBYYrrk8aQf1pNXNR8Q3b4sEbJulnZBTr19ty
   WNTk7WWPGdUph8sM3Q76y+XC6IfxG5LXI0xxhxzR7gksCQA/vEJ5GALhF
   hjrKPGyMf4X74mnPVMmOWl3rAMYllLO2cN6mISV9WvzIM6nKTWHn5CX5l
   Y=;
X-CSE-ConnectionGUID: S4a7wt6MTgyCZ5vgvYAPrA==
X-CSE-MsgGUID: L5HqA+1kRQSwj4IiZDJvmA==
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
   d="scan'208";a="253495165"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2025 11:10:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A8CFEE0CF0; Tue,  9 Dec 2025 11:10:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 935E1E00A5
	for <cocci@sympa.inria.fr>; Wed,  3 Dec 2025 04:34:38 +0100 (CET)
X-CSE-ConnectionGUID: WrSfGyV4RS2Rf1A6cZ7oVw==
X-CSE-MsgGUID: 5wpq+vXkSjGNY2KJCLs6LA==
IronPort-SDR: 692fafce_34VMJ4pZ0UTtL+4Ch6lQZqWbxkHIvsGCu76UjjuZjtSGvFE
 p2mIRR2ZtKRP1wk7ePXF3QHE+vbRLHbGMvLptBg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EeAACori9pgbLXVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0GAQELAYFtUoFhMwRUlCiCJJg8hV6BQD0RAQMBCwEBUQQBAQMEkWkCHgcBB?=
 =?us-ascii?q?DEIDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEiGQcOO?=
 =?us-ascii?q?4ZPDYJiAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEFAixfAQUSKAYBOAEDDAEFBRguMwEFARwGEyKCYIIjAQYRAzYDAaUBg?=
 =?us-ascii?q?QVCizyBNIEBgg0G2wUoDYJSAgcJAQqBNwGIUgGFboN+eicbgg2BPAuCeD6LB?=
 =?us-ascii?q?wSCIoEOhiKLZodZUnh4LAFVExcLBwWBIEMDgQsjSwUtHYEjIR0YE2BUQINJG?=
 =?us-ascii?q?AZnDwaBERlJAgICBQJAOoFmBhwGHBICAwECAjpVDIF3AgIEghZ9ggoPiAEBg?=
 =?us-ascii?q?QsFLn0lAgELbT03CQsbBpVTT4MtmU6PEaEOhCaKfI9VhwsGQoNxAV+TAZMZL?=
 =?us-ascii?q?odlkHOjfoUXAgoHBxEkgUUBOIFcMxoIJgqDIk8DGQ8xjXCEAL0IIjU8AgcLA?=
 =?us-ascii?q?QEDCZIegUsBAQ?=
IronPort-PHdr: A9a23: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
 nbeZSNxZO0s8HHn5FJlfzL3
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:yNyU06pKBA384itwABOaskUaV5rQeYIsimQD101hICG9vPbo7v
 xGuM5rqiMc6QxhJE3I/OrrBEDuewK5yXcY2/h3AV7mZniZhILKFvAe0WKB+UyaJ8SWzIc0vt
 YDT0E9MqyLMbETt7eY3OCWKadE/DDtytHRuQ6x9QYKcShaL45n9BlwEQuWHwlbQwNcFYMlGJ
 f03KZ6jgvlV3BSQMrTPBc4tiv4yOEjVqiKXffLPX8aAcC17Q+V1A==
X-Talos-CUID: =?us-ascii?q?9a23=3ABLE0TGvBdSGhe/EQtsyqqx3Z6IsaaEbT42buf3W?=
 =?us-ascii?q?DU1xnEZTLQm3P/517xp8=3D?=
X-Talos-MUID: 9a23:ZdXo7ARoKSQZAGQyRXSxmyl7d9lY4J+sJ2Y8y7YkkO2fawhZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,244,1758578400"; 
   d="scan'208";a="252451147"
X-MGA-submission: =?us-ascii?q?MDGK3Eg6JfCi5GzSktXRlWuJP8bIBEsOQx1k1Y?=
 =?us-ascii?q?BNlqdOPbMbxFQ0JmDQctKpxG+QJtaXN24MeklpeuS4o65zQ1X4uYOuB7?=
 =?us-ascii?q?wQajrw97C7ciovitjmGSULrz5kpMsPJtcyBl5gwHJ8/cCG4133huxThq?=
 =?us-ascii?q?43TYhBY0mHKEQART9aCUzSHQ=3D=3D?=
Received: from mail-pg1-f178.google.com ([209.85.215.178])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 04:34:38 +0100
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b98a619f020so4747803a12.2
        for <cocci@inria.fr>; Tue, 02 Dec 2025 19:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764732876; x=1765337676; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uN4c8sU/S8sKfqIqWSZ2ukImvsU3t4AIDPSRgGg4a6o=;
        b=KVGHe53qmsEcOpXGdWHtjJsA9xV3bn3/mYkLGaJjhFSIhvT2y93fdkm04lBQoN+iro
         6m+WnQW3k3X+wrJBPCOUlnXrT+u2yZSHtcS31zQ4LD2p4CcT/arWTWcFp2Ni5ym6Gyda
         LTgopcFuwpM1CeTljj76FK194oqJVlq/ul+pLxL+27VO3Hzn10OSZfX0zK6tZRFhhc8Y
         Atxf4eLt+aIEkLC/lLbkBbMJZwcqRjCGUG1cgY++IdOZlKqhYMnUGGCvDbPKeXHYNzfC
         hoQyPM/z4G7oQ3pL8zh47Nci/XpXSM0JiGhw/gMzg/JoB1cPBmasgsGc/zhbRvuvTO/h
         Wx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764732876; x=1765337676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uN4c8sU/S8sKfqIqWSZ2ukImvsU3t4AIDPSRgGg4a6o=;
        b=Z/vMxe7EoBYXGJy9/Aqnb28SyWbShn+8hENh3roqFlL2FJcyVp07N9LU2QvPun+VjH
         3fQiM96ZomtCNQV3XYPk4Ug1UDD6Bct3R5pbtSZGBOiepXTn7naUoVfe255U2REQQCpr
         NBaS82ADWh0GE1qNi/vRRhJtEUw/Vju/uI6S1PpQYRDdctJPMuZxrrDwrirkYYihgqKe
         ORPIiThPaDuM8HNEFb4ChddI8GBGCm5a3SOLUJavhTldK6WQh32hG62rmEUAfbAEMy3p
         eJHQQjn3F2dqwnWfla0eVlq3DYlhZ5xaASXMTADqlOIcszKCt5k838bigFihVGgBsOmb
         tUNA==
X-Forwarded-Encrypted: i=1; AJvYcCVCyTH7zjqiWpebU6dGouKWutg1ZJdiT89lr1pfxJ9rsZi/ySCHqa/zEVe6aCSMqDxobIQDyQ==@inria.fr
X-Gm-Message-State: AOJu0YzuITD/MaiQSS0pYTUgcS5zyihZ2pWerMuX6/+OeGKtfre+aCC6
	iS0KtlHt19ClbuTzsoEwesFLG3JUhDIebR4TdPqaeAL7x7xs3kxhwfrv
X-Gm-Gg: ASbGncsn0vACmiaDnliQb+shnj3m/HUtHVz4wru5sLkH8ZBB38A6iR7npg7wgWZ12x0
	f/rTnO2plTu4g3lvH2X4+6erNGnoXDDO0QYvVZMEBxX5nRI6VliSojYaetX+uEY2kwBb007SSzc
	B0e/IXsfdlW+l7bN8KVRqNp7ro5TXzxuoARlRKK1AqpKjo3j3hyDPSXGpYSlomqg3rMgLgCtaEo
	BmmQZs+yRiEkWzgf0M52MTygVrAu9R1Pf36c0UqMskxG0ZP53jUJnMHVtrIG5xS+ckrHimtM6M7
	bvS4I+NADDicVNAQrUP3XklViUqkXjzriNzmbL+6HnOd+RLFRTfoTIZmHwu9HoPwi30Z3DZwAfJ
	amS+M+GjDm5AUu8eBqbBcdUtsFC4ITpsIuE1LVaSk+K2RAKclPw9PAQE+5h0X5ep37dvFLi8FOX
	2lFe57duIycSdkGS1qepKZGjA=
X-Google-Smtp-Source: AGHT+IFOo3b067vZP6G4di0CLw5msqr+mDhAcC0nkiYdidAZ7X4NCaWsVzZpQDYswNnKmbz2SRQeIA==
X-Received: by 2002:a05:7022:1b08:b0:11a:273c:dd98 with SMTP id a92af1059eb24-11df0c487b1mr822518c88.20.1764732876419;
        Tue, 02 Dec 2025 19:34:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb057cb0sm96057395c88.9.2025.12.02.19.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 19:34:35 -0800 (PST)
Sender: cocci-request@inria.fr
Date: Tue, 2 Dec 2025 19:34:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-pm@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>, linux-kernel@vger.kernel.org,
	cocci@inria.fr
Message-ID: <0061398a-1b19-4249-a0d1-31ed2826770d@roeck-us.net>
References: <20251202193129.1411419-1-briannorris@chromium.org>
 <20251202193129.1411419-3-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202193129.1411419-3-briannorris@chromium.org>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 3/3] coccinelle: Drop pm_runtime_barrier() error
 code checks
Reply-To: Guenter Roeck <linux@roeck-us.net>
X-Loop: cocci@inria.fr
X-Sequence: 3255
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/0061398a-1b19-4249-a0d1-31ed2826770d%40roeck-us.net>

On Tue, Dec 02, 2025 at 11:30:26AM -0800, Brian Norris wrote:
> This function doesn't return anything any more, so the compiler would
> notice any bad error handling before any cocci script would.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>
