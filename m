Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EF4C32771
	for <cocci@archiver.kernel.org>; Fri, 19 Aug 2022 09:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:from:in-reply-to:date:cc:
   content-transfer-encoding:message-id:references:to:
   subject:reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=fUTn5/OKvyPpeFVE2zm6JdNB3J2Jy+u3XFmC17zSDdc=;
  b=TZ9c33eFJzMvWchwTCDB01J5cYbqFZhmqY0yr+55sFBaikyvoqfekD9F
   V0V88JQ2UK7H8Ygi8pvJvlzfBLTk8lIWLL33Ro6p9LXFzU0SMBTM2PQwX
   i28ug70g84/6HS89w5xLRI4wDx7nSCvkvUIEws9q2xtIyppB6N8Uu/IpO
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.93,247,1654552800"; 
   d="scan'208";a="49210050"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Aug 2022 11:58:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 53F85E0247; Fri, 19 Aug 2022 11:58:33 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 45F8EE0247
	for <cocci@sympa.inria.fr>; Fri, 19 Aug 2022 11:12:46 +0200 (CEST)
IronPort-SDR: y0t8oRFbyPfu6vIDcTkscuTrhc6XWG5S+n+FUG6mXR+XNvez6vG1eC7LgOlKAlYeyOpZlUQ9Y7
 kXv5+upVDADY1Nx/4NnNqkYcOFcGF46t4YGJ+kOvkSSso5ufs5Mwhu/xXQ4ALbdMo4e2fAy6kp
 UKUuum81pS2t1oIct8vWupNklbuAkg03kWOLkwAMzFgTvcTbmx56npWvH16Upf1M6GuHtn6ES+
 jaVXMwG76VzMreTozcuhH5lOIuRP5cBdWf+VIkYf8XM6IS0udd9STE6wegI5uMq0xJfviJRb4+
 88U88UNQAYR6wLJd139q6FtX
X-IPAS-Result: =?us-ascii?q?A0B2AABjUv9iXUPQVdFaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYIjBypQVy4EUIROjmeCJQOEJYcOgQmQQ4F8CwEDAQsBATkHAgQBA?=
 =?us-ascii?q?T+BVIJ0AoR6Ah0HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?AEGHAsJBxIVDgVgAWEDAUSBT4F0CwMEBicNgjUpAYNjAQEBAQIBEhEdARsdA?=
 =?us-ascii?q?QMBCwYFCwEMAgIYDgICIxEBBQEIFAYTIoJbAYJsAQMNJQMEDJtYgQRCijh6g?=
 =?us-ascii?q?RUFF4EBggkGgmGBbgoZKA0VUgNbfgIBBgkBCH8sAYZViHongRmBEIE8DBCCZ?=
 =?us-ascii?q?z6CYgSBXhWDQTeCLgSZPgQFFA8DAwIhAwkEBwUsHgIJAyMRAwsQEQcOARYBB?=
 =?us-ascii?q?AgBBAMBAQEOAgUHAgYDAwICAgIFAQIKAgECBAMGBgIDEAECBAEKBAIDCAIHA?=
 =?us-ascii?q?wIGBAoEAggCBAUDDQEDBQIDAQEDAwIEAQIBAQMIAQMCAwMCAgICBQIDAgICC?=
 =?us-ascii?q?QMEAQcDAgMBBAMBAgoEBAMEAgIHAgcCBAcCAQIGAwUGAgIBBwEBBAoEAwMDA?=
 =?us-ascii?q?wIFAgIDAgYSBgYCBAEDBAIKAgILAgcBAQIBAQEBAgMCBwULAQEBAwIDBgUCA?=
 =?us-ascii?q?QEDCAYCAQQBBQMBBAUDBwIBBQYCCQMDAQgDAQEFAQMEAwMDAgcDAQIMBAgDA?=
 =?us-ascii?q?wIDBAICAgIBAwIHBQgEAgkCAgIBAgICBAIBAxoBAgMFAgIJCwEEAgIDAQMBA?=
 =?us-ascii?q?QIIBAkEAgMEAgEBAwIBAgIBBQIOBgEBAQECAwMBAgMBBgcCCAIODgoBAwMDA?=
 =?us-ascii?q?gIFAgIBAgMCAgwBAQQCAQIBAgYBAwECAgMBAwECAgMCBgkCBAEFAwMCAgMBA?=
 =?us-ascii?q?QUOBQIEAgECBgUCAQEBBAEDBAQGAgIBAwMCDgIEAQQBAgEBIwMEAgMBAxcBA?=
 =?us-ascii?q?gECAwMDBAYHBQIBAhMBAgEBAQUBAgEBAwQEBwkDAgIEAwMFAQECAwIBAQEHD?=
 =?us-ascii?q?AICAhMCEwMBBgEOBRQDAgQCAgECAgoDAQICAQMCCQIBAgEFIAMBAQ8kAQECA?=
 =?us-ascii?q?gICAwQHAgEEBgMNAgIBAQEFBg0DAgMIAQwCBwMCAQMFAQICAgQBAgQKCQECA?=
 =?us-ascii?q?gECBAUHAgEIBgUNBQkLAQECAQMHBAMRAgUDBQUDAwIBBgQFAgMBAgEBAwQBA?=
 =?us-ascii?q?wQGAQECAwICAQYCAgEBAwMEAwECBgICBwIDAgEEAgMDAQEBBAICAgICAwMIA?=
 =?us-ascii?q?wIIBwUBBgECAQQDAgIBAgcBBAEIAgEDAwUDBAEKAw8DBQMBAwMCFAoFAQUIB?=
 =?us-ascii?q?gkCBAUCBQMCBAIDAwICCAMCBAMCCwMCBgQCBxMHAgMCAgUCAgICAgUEAwECA?=
 =?us-ascii?q?gICAgIFAgQCAQUBAgIBAgICBAECAgcEAgMBAwQOBAQCAgcBAgIBBgIHAwECA?=
 =?us-ascii?q?QQDAQEEAgQBAgUCBAEDAQIGAgQDCgICAwICAgYIAwMMCQIDBQIGAQECBwQCA?=
 =?us-ascii?q?gsBBgIHAgIBAgMRAQMCAQQFBQMDAwkCAgMCBAICCgEBAQECAgEFBQIEBw8CA?=
 =?us-ascii?q?gIEAgICAQMCAgEBAgIFBAkSAQECAwYEBgUDAggYAQYCAgEBAgICAwMCBgIBA?=
 =?us-ascii?q?ggCBAEEBQIBAgICAgQBAwYCAwEBAgECAgMDAgEEAgQDAwEBAgECAgIDAgICA?=
 =?us-ascii?q?wICARACBgYBAgICAgIDAgIBAgEFAQIBAgQCBwIEAwIBAgIFAgICAwEBBgIEC?=
 =?us-ascii?q?wEDAgcGAQMCBwUCAwECAwQDAwUGBQwIAQUBAwEFHwMCAggCBwIBBQMFAQ8DA?=
 =?us-ascii?q?gIDAgIBBAoBAgMFAgQCAQIBBAkHAgQBAgsDAwYCBwUYAQICBwQMCgICAgUGA?=
 =?us-ascii?q?gQBAQEBAwECAgECAwcCAwIEBQEFAgECBQQCAgEBAgUCDAECAQcGAgcDAgICA?=
 =?us-ascii?q?wEEAgECAQMDAgMBAQEDCQYFEU2YEYFAGYFCASsgMCuBJFiuF5MZBwGDVIsrl?=
 =?us-ascii?q?HkELpZjkg6WImCNOJVYhCYCBAEBAQMHBhAjEoEzA4ILMxojegEGgjYTKxABA?=
 =?us-ascii?q?gEBAQ0BAgEBAwECAQIJAQECjGOBOoNyhRSFTD80AgEBATYCBgEKAQEDCYVGh?=
 =?us-ascii?q?SUBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:eU/jpKBZeEMpzBVW/+Tlw5YqxClBgxIJ4kV8jS/XYbTApDxz32MFm
 GAYXmuDaK2CYGHweY91PIu/oxwH7cOBndRrOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6j8lkf5KkYAL+EnkZqTRMFWFw0nqPp8Zj2tQy2YjgU1vW0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoxeQhNFe9
 I1RiZbqYAc0FZbTuPoBVyANRkmSPYUekFPGCX22sMjWwkGfNnWynLNhC0Y5OYBe8eFyaY1M3
 aZAeXZdM1bZ37Lwnu3TpupE3qzPKOHpP4dP4CkmwjDFJfkjSJHHBa7N4Le02R9s15oWQK6BO
 6L1bxJDNzfZYRdrPG00BZ5ivsKDnnP5f2Vh/Qf9Sa0fujCPlmSdyoPFNNPKc9iObddUm0yCr
 yTH+X74C1cULrS3wj2O+XOEnf7KhSq9WYQIFbT++OQCvbGI7mkaCRlTWFfi5Pfn1QixXNVQL
 0FS8S0rxUQvyKC1ZvvkRByXnCaYghRGctpNONYlyB+RzpOBtm51GVM4ZjJGbdUnsuo/Sjory
 kKFkrvV6dpH4O39pZW1puf8kN+iBcQGBTRdOnJcHGPp9/Gm8d5j1EueJjp2OPft1oWdJN3m/
 9ydQMEDa1g7iMcK0+C28QmCjWzz4JfOSQEx60PcWWfNAuJFiGyNN9DABbvzt64owGOlor+p4
 Sdsdy+2sb5mMH11vHbRKNjh5Znwjxp/DBXSgER0A74q/Cm39niocOh4uW8gfBc1bZpfIma2P
 Sc/XD+9ArcDbBNGiocnM+qM5zgCkMAM6Py+C66KNoseCnSPXFbWoXkwDaJv44wduBF0zftX1
 WazfsGrAnIXYZmLPxLnL9rxJYQDn3hmrUuKHc6T503+jdK2OSDIIZ9YbwPmRr1otMus/VSIm
 /4CZpvi40sFDIXWPHKMmaZNdgBiEJTOLdWpwyChXrDTclYO9aBII6S5/I7NjKQ8z/oNy7eWp
 S3mMqKaoXKm7UD6xcyxQigLQNvSsVxX9BrX5AQgYgSl3WYNe4Gq4PtNfpc7Z+h1++lqzPoyR
 P4AIp3SDvNKQzXB2jIccZit9Nw4JEr33VqDb3i/fTwyX598XAiWqNLpew3Y8iNRXCe6sM0Jp
 aKti1HASp0ZSgU+V8vbMar9z164sXUHtvh1Wk/EfotadEn2odplLiXwirk8JMRVcUfPwT6T1
 gC3BxYEpLmV89VlroWR3a3d9tWnCepzGEZeDlL317fuOHmI5HenzK9BTP2MImLQWWbyz6OoO
 rdYwvT6B/sYxQoYvod5FYFr+qIw/d7YobFXk1Z/F3LRYlX3U75tLyXU3cRLsaERlLZVtRHsA
 RCK89hefLiFYYbrTgFXKw0iYeCOk/oTn2CKv/gyJUz74g5x/aaGARoOZUjS0HQFIesnKp4hz
 McgpNUSt161hC0sP4vUlStT7WmNciENXvl1rJ0cG4O32AMnxksYOs7ZAy7ypZyDMpBCbBZsL
 TiTi67Pwb9bwxOaIXY0EHHM28tbhIgP6E8Wlg5cfwzRl4qXnOIz0T1Q7S8zElZfwCJB3r8hI
 WNsLUB0efiD8joAaBKvhIxw99ytxSF1+3AdD3MMnWzdCkSkDynDcjJ7NuGK80QUtWlbe1C3O
 V1eJHnNCV7XkAPZh0PemnKJb9TsSNVw8kvJn8XP8wGtAcwheTS86kOxTTNglvYkaP/dQGXIo
 OBr+KB7bqiT2ev8ZUEkI9Hy6In8gyxo6ICPrT+NMU/J8azhlOmO5AWz
IronPort-HdrOrdr: A9a23:LCu9xqP02/ymX8BcTuKjsMiBIKoaSvp037Dk7TEJdfUzSL3hqy
 nOpoV56faQslwssR4b6La90cW7MBfhHNtOkO4s1MmZLXLbURqTXeNfBOLZqlWKexEWtNQtr5
 uIG5IeNDSaNykesS+V2njELz/i+rW6GWKT6Ns2A00DcegTUdAd0+6xMGimLnE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,247,1654552800"; 
   d="scan'208";a="49205074"
X-MGA-submission: =?us-ascii?q?MDFZ6HAJ2qiOYfYcaiVc/3AQEY/0K07DRbvdm+?=
 =?us-ascii?q?AJlFXQAYRO9e5KlRG1W/8tcvfua6Gy0ODfYXQSsH8muTsQhztWGaLwzC?=
 =?us-ascii?q?ogzWwLkUZ3ZR9Jt0+MbqLRzL2CH1vYVGQItCI37978fjvCu1FVQ/8/DC?=
 =?us-ascii?q?e7ztFpjDjXLmHdR+ojMmNCQw=3D=3D?=
Received: from mail-ed1-f67.google.com ([209.85.208.67])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 11:12:45 +0200
Received: by mail-ed1-f67.google.com with SMTP id s11so4876919edd.13;
        Fri, 19 Aug 2022 02:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=fUTn5/OKvyPpeFVE2zm6JdNB3J2Jy+u3XFmC17zSDdc=;
        b=ITYP7wHUWWADSoQBl/fpAfxQFuSPiDYt4DdZBCvdMai/Esly47nPLLhX7sdJgEP02e
         J4gSZdk5W0u4PqQcojWlFqT+acK/3Jm0zCc7CMs858hgpz5XfIWoi2UobdzwvlgeIvqU
         ItqfTym49q2bmKkwAznViVxr9u+m/qnSR9b8z/N9kvrHT91zqclvrHI1Qk79ezoRAFij
         WWgKtaNc17DkNXFRBgWQwthxwq1nBs0Et/WG/5/VeT/po+xdvwo8tihK4tooOSremA1s
         p45F9YCD7qwTspx91I96e+/Y1aWJRF7cr4owaZ/KaImuJRIsNjQSGoxUIQnbiyJ104lS
         2WZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=fUTn5/OKvyPpeFVE2zm6JdNB3J2Jy+u3XFmC17zSDdc=;
        b=M4B8fjgDPYPzOjdjTi51tMKhmxMGcbO3R1GQ1imsPGpneAXBBgGzm+F6jtS2o/1c5G
         6RQFNwbr4YvJ+DctNQaZKIVuiJmzptONuN9btzm30Cc6J6BDmhGTYZpQfaQQTFH+c/Gk
         4EKoA39n196gEv5+fEkunrwVSM+g+XzshWax7Rh8iO4tayhWgipTw9gYSw3pPv5mcfbR
         jX5lxdf8XeT6eb5j0bYmlW893uUQIoR2Dhux3glvTX8DimRgco+/r5jR63EROwsnsFLg
         8H7ghfOJQlV8Y2KZhS/1WQUylavjTUCi/8SBYt0fLTqon7+aIjg/rslU14Cg6jbf9jRI
         tvAg==
X-Gm-Message-State: ACgBeo0Yjaq7QpsgDgFyWkLQTrhuWDVLJ9wPkVwA8we8lplwTgpjnnfi
	GzE5BuHCAeDjlWrm3hAi1yc=
X-Google-Smtp-Source: AA6agR7jMTEbKY9DvA7uvrHNJrl36NmrMZjHbxDVqBdWYTc7rs3tI20dL/EE0xJ9moDBKimfZOnY4A==
X-Received: by 2002:a50:9f44:0:b0:445:dfca:87da with SMTP id b62-20020a509f44000000b00445dfca87damr5267689edf.105.1660900365181;
        Fri, 19 Aug 2022 02:12:45 -0700 (PDT)
Received: from smtpclient.apple ([46.183.103.8])
        by smtp.gmail.com with ESMTPSA id b18-20020aa7c6d2000000b0043b986751a7sm2711963eds.41.2022.08.19.02.12.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Aug 2022 02:12:44 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
From: Jakob Koschel <jkl820.git@gmail.com>
In-Reply-To: <cf4058d8-13ca-0637-fe0c-d9d8582c5673@web.de>
Date: Fri, 19 Aug 2022 11:12:39 +0200
Cc: Julia Lawall <julia.lawall@inria.fr>,
 cocci@inria.fr
Content-Transfer-Encoding: quoted-printable
Message-Id: <17A83354-2406-47E5-94EE-4955E09819DA@gmail.com>
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
 <alpine.DEB.2.22.394.2208162306410.2625@hadrien>
 <A564705D-53D2-44E9-BAF4-AE99E78B09ED@gmail.com>
 <alpine.DEB.2.22.394.2208171631050.2482@hadrien>
 <92b5eb33-9c76-7e45-7651-6296c9795a67@web.de>
 <88152C77-84AD-4515-A403-71F827180FD9@gmail.com>
 <cf4058d8-13ca-0637-fe0c-d9d8582c5673@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] Working with parameter/expression lists by SmPL
Reply-To: Jakob Koschel <jkl820.git@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 522
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/17A83354-2406-47E5-94EE-4955E09819DA%40gmail.com>



> On 18. Aug 2022, at 19:42, Markus Elfring <Markus.Elfring@web.de> =
wrote:
>=20
>> Let me show what I was trying to archive and how I solved it:
>=20
>=20
> How do you think about to achieve further software adjustments?

I'm trying to detect certain code patterns spanning across files with =
this.
They will *probably* not easily be automatically patchable since I'm =
trying to
find bugs with this in an ongoing research project.

>=20
>=20
> =E2=80=A6
>=20
>>    interesting_func@p(..., i, ...)
> =E2=80=A6
>=20
> I interpret such SmPL code in the way that the specified position =
variable
> could be omitted because it was not used by another subsequent SmPL =
rule.

You're right, the positions can be omitted here, but I'm using them with =
a
simple python script afterwards to report the matches I found where the =
positions
will be useful.

>=20
>=20
> =E2=80=A6
>=20
>>    e =3D e1
>>    + // here the argument to interesting_func was assigned
> =E2=80=A6
>> +++ /tmp/cocci-output-test1.c
>> @@ -6,7 +6,8 @@ int interesting_func(int argc, char *str
>> }
>>=20
>> int main(int argc, char *argv[]) {
>> -  int x =3D 0;
>> +  int x =3D 0
>> +    // test;
>>=20
>>   func1(x, "asdf");
>> }
>=20
>=20
> Do you vary comment additions for your test results?

yes exactly.

Only issue I'm having now is that it doesn't work across files.

I've found this [Link], suggesting to use '--file-groups' or =
'--kbuild-info' to=20
o analysis across multiple files. I've managed to get '--file-groups' =
working
on a small example but it will get challenging to do on the entire =
kernel.
The '--kbuild-info' option *looks* outdated at least I couldn't find an =
easy way to get
it running on the kernel.

- jakob

>=20
> Regards,
> Markus
>=20

Link: =
https://lore.kernel.org/all/alpine.DEB.2.20.1711300716120.2079@hadrien/t/#=
u=
