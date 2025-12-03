Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476FBD3B7EA
	for <cocci@archiver.kernel.org>; Tue,  9 Dec 2025 10:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=sender:date:from:to:cc:message-id:references:
   mime-version:in-reply-to:subject:reply-to:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=YrypMwcN4TiTIMcIjUFPxlrx91p/QDVVVhJWJD6ny4I=;
  b=qP4iuVa5oiLJvdabJkYhxsDst/uT8W4/GxwteAVLQ6S6/n08UNi3IApD
   JFrqLIQwPGYhW53dOAwZgYaLmQRLj3FvDGg8By7ma+qIjl8zSaNQOana6
   gpi8WIxz7SX42p+iHzOi2uPkoEHihHFuZEC+7cM1JIq97FBU41yXlPCPp
   A=;
X-CSE-ConnectionGUID: cB99WU5iSjakcNhwNSSvrw==
X-CSE-MsgGUID: IZTpqnUdTjCraI3bvo7e2w==
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
   d="scan'208";a="253495096"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Dec 2025 11:10:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 844E2E02E4; Tue,  9 Dec 2025 11:10:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 60A83E00A5
	for <cocci@sympa.inria.fr>; Wed,  3 Dec 2025 04:34:12 +0100 (CET)
X-CSE-ConnectionGUID: mTnXtrZLQD29k+peVGQdUg==
X-CSE-MsgGUID: B7aRFAkARpOXHEBL7mpT/A==
IronPort-SDR: 692fafb3_hFADXJm/ciOQjjhaXJkcTFFAo5zzEvuf5r7IJcPnQlAyD88
 3/pwjlWB9d+Wmo7S9WCcXRr62Jlg/T5ItUM+zTg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FEAwAhry9pgbDSVdFagQmBUAKBbFKBAl8zBFQElCSCJ?=
 =?us-ascii?q?Jg8hx49EQEDAQsBAUQNBAEBAwSRaQIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QEBAQ0BAQUBAQECAQECBAYBAhABASIZBw47hk8NSQEMAYILAYEkYQIFAzsBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEFAg0fXwEFEigGA?=
 =?us-ascii?q?TgBAwwBBQUYLjMBBQEcBhMigmABgiIBBhEDNgMBEKRygQVCizyBNIEBgg0G2?=
 =?us-ascii?q?wUoDYJSAgEGCQEKgTeIUwGFboN+eicbgg2BPAuCeD6CSoFbhmIEgiKBDoYii?=
 =?us-ascii?q?2aHWVJ4eCwBVRMXCwcFgSBDA4ELI0sFLR2BIyEdGBNgVECDSRgGZw8GgREZS?=
 =?us-ascii?q?QICAgUCQDqBZgYcBhwSAgMBAgI6VQyBdwICBIIWfYIKD4gBAYELBS59JQIBC?=
 =?us-ascii?q?209NwkLGwaVU0+DXBCBIJQ6gzWPEYE1n1mEJooiWoEilT4GQpdSkxkuh2WQD?=
 =?us-ascii?q?WaMDoF6mw0CCgcHESSBWiSBXDMaCCYKgyISPQMZDzGNfBaDXoUTt3IiNQI6A?=
 =?us-ascii?q?gcLAQEDCYk3iGeBSwEB?=
IronPort-PHdr: A9a23:lVL/4Bfkgh9BNzf1vwyOyPdHlGM+49fLVj580XLHo4xHfqnrxZn+J
 kuXvawr0ASVG92DoKsU06KW6/mmBTdbp87a8TgrS99laVwssY0uhQsuAcqIWwXQDcXBSGgXO
 voHf3Jeu0+BDE5OBczlbEfTqHDhpRQbGxH4KBYnbr+tQt2agMu4zf299IPOaAtUmjW9falyL
 BKrpgnNq8Uam4RvJ6g+xxfTvndEZ+tayX5rKF6Pgh3w4tu88IN5/ylftf8s+dRMXbn0cqg9U
 LdVECkoP2cp6cLkshXOURGB7WYGXGUMlRpIDQnF7BXkUZr0ryD3qOlz1jSEMMPvVbw6Viys4
 KhyRBL2hykJKiY1/27LhMN+iqJbuw+hqAdkw4HIeoGVNeFxcb3bcNgHWGdORMdRVyhGAoOhc
 4sCCvcKMOhEo4XhoVYFsACzDhewCuzx1jBIh2f23awk3OQnDQHGxxErE9YXvHjJsNn5KKIeX
 Oaox6fK0DrDdetb2Szz5obIbB4sv+yCU7F+ccXe1UYgCgHKg06MqYD5JT6ZyvgBv3SF4+dmS
 Omhi3QnqwZ0ojW3x8ksl5fGhoQJyl/a7yVy3Zo7JdqmR0FnYt6vDZxdtyWbN4twX8MjTHplu
 Dw9yrIYpZG7fzEGyIk8xxLFbfyIbZSI7wvlWe2MLjh2mGhrd6ijhxau70eg0Ov8W9G03VhEs
 idJjMfBumwR2hDO6sWJSvhw80aj1DuO1g3e5PxILFwomafYKpMszKA9m5gOvUnBECH6hUr4g
 auZeEk4/OWj9urpYrLjppCGNo90jBnzMqcwlcylB+Q3LAwOU3Kc+eSm273u+1DyTrZSjvAuj
 KXVrJTXKd4Yq6O5GQNZzJsv5wqlAzu70tkVnGELIExEdR6bk4TkPkzCLfLkAfujhlmjjjlmy
 +7bMrDkA5jBMHbDnKvkcLlg8UFRxwQ+wNVF6J1KBLEBLvf+WkHvu9PEEhA0Nhe7w+j6B9h90
 I4VRHiBDbWDMKzItF+F/uIvLPeIZI8SoDv9LuIq5//qjXMggV8dc7Sl0YIZaHylHPlrIl+VY
 XXrgtcGHmcKuhQxQPb2h12FVD5ff3eyX6Qi6TEnEI+qE5vPS4S3jLGC3Cq3BINaan1aBlyWD
 HvldYSJV+8JaC2II89hljIEVaKmS48kzRyuuxX6y715IeXI+S0Vt4nu1Ndw5+LJlBEy8SZ4A
 Nia02GIV210hH8HRycq3KBjpkxw0kuM0a9kjPNEFNxe/OhJUwc/NZ7E1eN2EdHyWgTbfteIU
 lmqWNumASspQtI32NABe1x9FMm6jhDfwyqqBKcYm6GTCJw77K3c2Hv/KdxlxnnIyactl0MmT
 dVRNWOlnKBy7w3TCJTIk0Wdjqqqbaoc0DPU+GeN0GaDvkBVXBR/UaXCWnAfaU/Wosrj6kzeS
 L+uDKwrPRZCyc6DL6tHcsXng1pIS/n9JNrTf2S/l3+tChaN3LyMdpbldn0F0ivEEEYKnBgf/
 W2eNQgwHiqvuX7TAiFzG173eEPs6ed+p2u7TkAqywGKaFVs2aKs9BANivLPA88Ui5geuS4n4
 xNzBky8xJqCAcCBrgxne79GYMgV61dd0mfYqgk7OYavefNMnFkbJitqskXy2g8/MIJNmsti+
 HcryhdiAbif3VhCMi6Dm5b9JuuEeSHJ4BmzZvuOiRnl29GM9/JKsaxgw72ClASgF055tm5iz
 8EQyHyEoJPDEAsVV5v1FEcx7Rlz4b/AMWEm/42B83pqPOGvtyPancozDb4q0BGtdNQAGKyBH
 Q72VcYdApvmM/QkzmCgdQlMJ+VO7OgxNsKieeGB3fukJuFtlzH5pWtC6YF5lEmL8nk0UfbGi
 rACxfzQxQ6bT3H8gVOm59jwgpxBbCoOE3CXzCHlAMtJaPQ3c99UVyGhJMq4wtg4jJnoM5JB3
 HikAV5OmMqgeB7JKkf4wRUVzkMP53quhSq/yTVw1TAvtKuWmiLUkazkc1IcN2hHSXMH7x+kK
 JWoj90cQEmjbhQ43Bqj60HgwqFHpaN5Z2DNSEZMdiLyIilsSKy1/raFZsdO7tsvv0A1GKyze
 1eXQb2iixQf2iLnWWBZwXFzdj2nvIn4gw0vkHiUfz54qHvUf901xA+KvoSNA64MmGBfHG8h1
 meEYzr0d8Ok9tiViZrZ5+W3Vmb6E4ZWbTGu1oSY8i2y+WxtBxS72fG1gNzuVwYggkqZn5FnU
 zvFqBHkb8zlzaO/ZKhoZE5lD1yjw8V/E4B61IA3gdtDvBpSzoXQ5ncBnWrpZJ9Uw6XzZ3lSb
 TEOyt/RpgPi3QcwZmLMzIX/WHKHx8JnbNTveWIa1BU26MVSAbuV5rhJ9cdsimKxthmZIf10n
 zNGjOAr9GZfmOYR/gwk0iSaBLkWW0heJy3l0RqSvZiyq6BeZWDndrbVtgI2ksqmAbqB/SlTX
 X/4ftEpGio44shkMV3K2WH+8cm+IIiWPY9V7ETM1U6f0aBcM9opm+APhDZ7NG6Y3zVt0OM9g
 RF0nNm7sIWBN2Rx7fe8Cx9cOCfyYpBb8TXsgKBC28eOitr3T9MxR3NRBcOuFK32Q1dw/bz9O
 g2DESMxsCKeELvbRkqE7Vt+6mnIC9atPm2WI38QyZNjQgOcLQpRmlNxPn1yk5gnGwSt3MGkf
 l1+42Vb6UT/pxBPlcpnMhD+ViHUowLiOVJWANCPaQFb6A1P/RKfPtaZ4+lwQAlX+5SgqEqGL
 WnRNExYSGoOXEKDHVXqOLKjsMLB/+avDe27N/LSYL+KpL87Nb/A1de134Bh5TrJKtSXMywoE
 aggwkQaFyMxC4HDlj4IUSBSiy/dc5vRukKn4iMuy6L3uPXzBFCwuc3WUeYUaZM3vEnoyaaba
 7zK3Hc/eWsej8lcgyePkedX3UZO2Xs3KX/wQfJZ5HSLFOWJy8o1R1Yac38hbpIWqfhnj08WY
 4iDzYqknqhxivp/Y7tcfXrmnMzhJckDImXmcUjCGF7OL7OeYzvC38DwZ6q4D7xWluRd8ROq6
 36dFAf4MzKPmiOMNVjnOPxQjCydIB1VuZ2sOhdrB2/5Sdv6axq9eNZphDwyyLcwizvEL2kZe
 TR7dkpMqPWX40Y6yr1nHHdd63N+MeSesyOQ7u2dMphP9PUyXXoymOVd73A3jbBS6WAMRfB4n
 jfTss87o1yilbrqqHIvWx5PpzBXwYOT6B86aOOJq98aAC6CpU1TvgDyQ1wQqtBoC8PiofVVw
 9nLz+foLStatsnT5Y0aDtTVL8SONDwgNwDoEXjaFlhgL3bjOGfBikhaiPzX+GeSq81wpYLrl
 ZENFZdUUVU0ErURDUEvT7lgaN9nGygpl7KWlptC/X2lsBzYX9lXpLjCX/OWRO3hcXOX1OYaI
 RQPxrz8IMIYMYixiCkAIhFq2Y/NHUTXR9VEpCZsOxQ1rEt6+397VmQv2kjhZ2tFAVcWHP+w2
 wY4005wOLtzsjjr5FgzKxzBoy5iyCHZdv3qhDmQdHj6K6LiBOm+7gL7skEwNtXwRAMnNWWP
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:/27676/RIzHWVE7QCFluk+AjI+orL9Y04lQ7vn2ZhyYlC/Bws/
 re48jztCWE9Ar5PUtLpTnuAtjlfZqxz+8T3WBVB8bdYOCEghrUEGgB1/qY/9SIIUSXnZ8+6U
 4jSdkFNDSZNykYsS/U2njcLz9K+qj+zEnHv5a5815dCS5tcL9p9Ap0B0K2FUdsVBBaCZdRLv
 ahz/sCiT7lV3p/VKqG77o+MNQrZeenqHsrW3877tcciDWzsQ==
X-Talos-CUID: 9a23:kmSdymOFOPkO9+5DXRVhxFIOKOQcXieMzzTILnGXMGpUR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3ABfmQeQ41PpL5OtQo5UG7Mc3oxoxCvK2UJmkOuK8?=
 =?us-ascii?q?enPmkGAZUZDKFsHOeF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,244,1758578400"; 
   d="scan'208";a="132605641"
X-MGA-submission: =?us-ascii?q?MDEG0JnEe6pUPypgrLAIPTGqlpfaW9T1T9f390?=
 =?us-ascii?q?dt+vbIOslG/p5mOUyXImhx2e0DPywZlYpAWBuqBt53ASEp4wlsufGyG9?=
 =?us-ascii?q?jv7UIoW2jrrw5FcoO1YRKPgx0Z4r0AxtC4Ys9JGzA0tiTRzwFs+hRcyb?=
 =?us-ascii?q?7xh5S82Rbtcp44+bPZ1fNF3A=3D=3D?=
Received: from mail-pf1-f176.google.com ([209.85.210.176])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 04:34:11 +0100
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b9a98b751eso4533919b3a.1
        for <cocci@inria.fr>; Tue, 02 Dec 2025 19:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764732849; x=1765337649; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrypMwcN4TiTIMcIjUFPxlrx91p/QDVVVhJWJD6ny4I=;
        b=L06nkXnR+Y5gtUHFMZOpxJ3778WTUx3Gyt0Ip4VXrIw4eHahwRMQNWsCp0+pp8GCUP
         5XVR44Y2w0RjOTg4aUCUyEbZ8Nz+4LG3tnekcjsPtawrfHtKBp2loc6tuUKESz8bdyIm
         3kLZJ1Us4TNAFLU1X3gGsKAvruJkG1jCkKK7WjWWPilTNpW5YUFBeIMWfGvKQ67fhoxG
         Vsk9Hm7R1b1PYzqwdMdyKSDqrVbjU3vsmezGtba2GDnZu9bEuepIyFSIOAO2X43RpZuA
         ifMXrR9gfzqi3n0UyVcxqD1dOk/H4bOBD62dAld3WgFCwJ2vzaypKI3pI4FhY3YZxmXy
         z4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764732849; x=1765337649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YrypMwcN4TiTIMcIjUFPxlrx91p/QDVVVhJWJD6ny4I=;
        b=YnCqJo3/iSBLgwWDnCDnMAeUW66POBzAAUdY15jVGRgGtO2pmhZ4dBKgUSqwKzI2Mg
         GBO0CnsE1OYmoc9nGNJl4L0l7B/xlpOnTHtNN3VojvtqJccjlU3RJvxalLY2ia0PVokI
         dPDe2cmfqp5FVflvQriPvyqFPI90fruUaQTh8FeqjgIA8lx1s3fonBI3IzKzkjWmNhmx
         kz+0pREeiZXtZEKprArt2eKWotDsStkjXmKhp1FEJhkwx530ZbzO4IA3wQ7F9FnXTKMJ
         wiUHjvcT7McALun5Ngmjyvqrt1iMdB1uqbnChl+jGYa9oQyr4flwHts1CyrYOSMC0i/U
         5qkg==
X-Forwarded-Encrypted: i=1; AJvYcCViuuKzeOSmQrUwi0J4UMe2Oew5LnDvgDaWXq7LFRH7F0K5ZLWSmBMnCgNBK6q5XCz0MBH2YA==@inria.fr
X-Gm-Message-State: AOJu0Yxm9ggMfxNHpuZi29o4VEcSIUXES16sNxexYC3PiuEZN/BSSsgB
	OtxVm9DK7XO8YOvu9TMRJ4NFafoO3wlj6H1/UjqWSEWApKCLOkE/5mM8zv9IMA==
X-Gm-Gg: ASbGncvwWc26p1RRSU+iSyDRk1Ds/VIZ0PKlJb9dX0pFfgvxC+eXkln67alLeGVTAIn
	tFFBblHPqLLHMce202STyvmnKpwHbX5ummP9HuCKSI556ClYRraQUe9daettFCXs4uC8zZw2Z2U
	6lYz4WHyi7thdOJFB9NRjDwOcI5rA2dnPsel56xWMWSANa9TPe7KRIYhxkfSzcZ1Onv/xSjia9B
	xpYI74fZoQEhs47EK8kCWcQOJTpVnkK3sG9x6i1Sb4L7ypdOVZMEc3QffBI0aEcwPQpmq5zmDNY
	Sw26KVesTJhoEy1kTP7NF7NIvRLRqxmcMPOIy/7pc77nFrUdKqnfjwHU6EwHAlsSwvmaRnCnMOZ
	otUAuBXvhruwUNpsEbHND+0bONppMhnXQh4tjPdTWPh/6JWG2MiTNfrmOAUopxTdZ6XpfuXssIN
	n9xNgkBQEkUEx7lewQSdqi5ig=
X-Google-Smtp-Source: AGHT+IHb2Bm444wTR/SyhoFk/OdfrkP+670oMUjj/BL8tdpSmodPv0u+GrGuSHULggAy1sTlh5P04w==
X-Received: by 2002:a05:7022:f415:b0:11b:9386:a38b with SMTP id a92af1059eb24-11df0c4c8c4mr768810c88.46.1764732849328;
        Tue, 02 Dec 2025 19:34:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5fcasm92986328c88.2.2025.12.02.19.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 19:34:08 -0800 (PST)
Sender: cocci-request@inria.fr
Date: Tue, 2 Dec 2025 19:34:07 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-pm@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>, linux-kernel@vger.kernel.org,
	cocci@inria.fr
Message-ID: <0f729108-6928-4644-b02a-fa7020cdffc4@roeck-us.net>
References: <20251202193129.1411419-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202193129.1411419-1-briannorris@chromium.org>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 1/3] PM: runtime: Stop checking
 pm_runtime_barrier() return code
Reply-To: Guenter Roeck <linux@roeck-us.net>
X-Loop: cocci@inria.fr
X-Sequence: 3253
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-12/0f729108-6928-4644-b02a-fa7020cdffc4%40roeck-us.net>

On Tue, Dec 02, 2025 at 11:30:24AM -0800, Brian Norris wrote:
> Apparently this test is the only code that checks the return code from
> pm_runtime_barrier(), and it turns out that's for good reason -- it's
> inherently racy, and a bad idea. We're going to make
> pm_runtime_barrier() return void, so prepare for that by dropping any
> return code checks.
> 
> This resolves some test failures seen like the following:
> 
> [   34.559694]     # pm_runtime_error_test: EXPECTATION FAILED at drivers/base/power/runtime-test.c:177
> [   34.559694]     Expected 1 == pm_runtime_barrier(dev), but
> [   34.559694]         pm_runtime_barrier(dev) == 0 (0x0)
> [   34.563604]     # pm_runtime_error_test: pass:0 fail:1 skip:0 total:1
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/lkml/93259f2b-7017-4096-a31b-cabbf6152e9b@roeck-us.net/
> Signed-off-by: Brian Norris <briannorris@chromium.org>

With this series on top of v6.18:

Qemu test results:
	total: 610 pass: 610 fail: 0
Unit test results:
	pass: 666898 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
