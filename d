Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B329CC433EF
	for <cocci@archiver.kernel.org>; Thu,  2 Dec 2021 18:27:53 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.87,282,1631570400"; 
   d="scan'208";a="8004058"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Dec 2021 19:27:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 50256E01B6; Thu,  2 Dec 2021 19:27:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5AFE3E0163
	for <cocci@sympa.inria.fr>; Thu,  2 Dec 2021 19:27:47 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=charles.letizia11@tesco.com; spf=Fail smtp.mailfrom=charles.letizia11@tesco.com; spf=None smtp.helo=postmaster@mail.proactive.nl
IronPort-PHdr: =?us-ascii?q?A9a23=3AE7hXNBKKZWEJJxT0rtmcuOtmWUAX0o4c3iYr45Y?=
 =?us-ascii?q?qw4hDbr6kt8y7ehCFvLMz0RSQBN+TwskHotKei7rnV20E7MTJm1E5W7sIaSU4j?=
 =?us-ascii?q?94LlRcrGs+PBB6zBvfraysnAJYKDwc9rDm0PkdPBcnxeUDZrGGs4j4OABX/Mhd?=
 =?us-ascii?q?+KvjoFoLIgMm7yf2+94fSbghIizaxfK5+IAurpgjNq8cahpdvJLwswRXTuHtIf?=
 =?us-ascii?q?OpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3sp683xtBn?=
 =?us-ascii?q?MVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Xymp4aV2Rx/yk?=
 =?us-ascii?q?CoHLT43/n/KhMJ+j6xUrw6uqRNkzo7IeYGYOuZycr/Bcd4YQ2dKQ8ZfVzZGAoO?=
 =?us-ascii?q?5d4YBEeUPM/tGoofkulAAtx2wCBexD+7o1jBIhmX53bc+0+s/CgHKxgggEMwSs?=
 =?us-ascii?q?HTVrdT1Nb0dXf2owKTT0TXMcehW1iv66ITSbh8hpvSMUKt2fMHMxkYhCxnLgU+?=
 =?us-ascii?q?MqYz5ITyVzOINvnCb4eduWuyiiGoqpQ9vrzWh2sohi5fFi58Ix13Z6Sh0z4I4K?=
 =?us-ascii?q?N+2RkN4b9CqH4dduiOHO4Z0Rs4sQ3xktDs0x7AIv5OwYSYEyJMixxHFavyHdZC?=
 =?us-ascii?q?F4g79W+aKPTh4g2pleLajiBqo7Uegzej8W8+p21hJtipIitrBum4X2xHX5cWLU?=
 =?us-ascii?q?OVx80mh1DqVyQzf9v1ILVg6mKbBNpIszbA9moANvUjeESL6glj6gLGUe0gi5+O?=
 =?us-ascii?q?m8f7oYq/8qZ+ZL4J0ih/xMqApmsGnBOQ3KAkOX2yB9eSkzr3j+lf2T6lWjv03j?=
 =?us-ascii?q?KnWrorWJcIfpqKhAg9V1Jgs6wqnAjqlztgUh30KIV1fdB6ZgYXkO0vCLO7kAfu?=
 =?us-ascii?q?jm1islS1kx/HCPr3vGJXNKX3Dna/9crZ98UFc0g4zws5E555ODrEOPu7zWk7wt?=
 =?us-ascii?q?dzZFBA1LhG4zv37CNpjzYMRRWWPDrWFP6PVtF+E/vgvLPWUZI8JpDb9LOAo6OL?=
 =?us-ascii?q?pjXAlhVAdfLKk3YAXaXC9BvRpOV+VYXvqgtcbEGcFpBAyTOLwiA7KbTkGbHG5V?=
 =?us-ascii?q?KMU5zchCYvgA52QfI21hK2923KwHpRMYm1dTFSBDXb6doysR/oXYyWPIddlmXo?=
 =?us-ascii?q?PUr3lA4Qh3AuquRS8z7d7L/jV83FEnYr508Ry4ejalBV0/jtxXOqH1GTYc0xPt?=
 =?us-ascii?q?URAfxsdlPR0oUVnzlqYl6x1n/1KFNUKvttVXxwxMtjXyOksWIO6YR7IYtrcEAX?=
 =?us-ascii?q?ued6hGzxkFrrZJvcSbl12HJOpiRWRh0JC4pcQnr2PQoQu9avXw3nvKoB7zySev?=
 =?us-ascii?q?EHOp0UrWcBIc2ahg/wjnzU=3D?=
IronPort-Data: =?us-ascii?q?A9a23=3AAcMTZaKuzkbZMrFEFE+RiJQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHDq3D8h0TZRm2FOUWmOb//eZ2GheI10atixox9XsZ6Dy6c2QQE+nZ1PZyIT+?=
 =?us-ascii?q?JCdXbx1DW+pYnjMdpWbJK5fAnR3huDodKjYdVeB4EfyWlTdhSMkj/jRHOKmULS?=
 =?us-ascii?q?s1h1ZHGeIdg9x0XqPpMZi2uaEsfDha++8kYuaT//3YDdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?gm7f/NFUQRbfZIQmQhzxQX8BOgDAS/GpjjuBhb6daMx8P49mKt4gZJNFlvpy5U?=
 =?us-ascii?q?wMkJevIlfgcQRhRSnhWIaBd87iBKn+62SCW5x2eKye0mKwG4EYeZNBHpb4oaY1?=
 =?us-ascii?q?UztQTLzsGbziYlueuyfS6TPNtj4ItNqHW0Ck3rik1iGufVOJ/FMiFG7GQsIcej?=
 =?us-ascii?q?Gxs29QVSK6YOt5GPBNxSj/FRzFPH3YeLLMgmdyzikXlVSkB8AfN4fIji4TI5Al?=
 =?us-ascii?q?40byrKMDSc9eWRNtY2ECczl8qNl/RWnkyXOFzAxLfmp5tugPOoc8/cIcbFbn+7?=
 =?us-ascii?q?uRtiVaPx3IeThsSPbd+iZFVlWbmM++z6WRNksbtkUT23FCmVdL6GRa/pRZoezY?=
 =?us-ascii?q?CDsFIHbRSBB6llsLpDsXwOoTAZiJMc9ch8sQxQFTGE3fhc8zBXVRSjVFedZ5RG?=
 =?us-ascii?q?np4Y99/1ej54FLuvRM5cDY=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ARe51Ha7gzD2dA26/LgPXwP7XdLJyesId70hD?=
 =?us-ascii?q?6qm+c3NomofyrbHIoB19726QtN9xYgBDpTnuAsi9qB/nmKKdwLNhW4tKPzOW21?=
 =?us-ascii?q?dATrsD0WPiqweQYhEWn9Q1vZuIGJIRNDSGNzNHZKjBjDVQa+xQpOVvrJrY/ds3?=
 =?us-ascii?q?chxWJz1XVw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0C0IQAdD6lhT8jrXlJaGwEBAQENAS4BA?=
 =?us-ascii?q?QEDAwEBAQ4BAQEFAQEBCYFbgToCAQEBAQE4WUENIXAxhEeJA4VrgiUijFCJCIZ?=
 =?us-ascii?q?bgWgLAQMBDRICHQ4CBAEBhVgBBII2AhoDDDQTAQIEFQEBBQEBAQIBAwMEAQYBA?=
 =?us-ascii?q?RwJEQUDKAEKIoVoDYIiEyKEAQETJighHAIYDgI/BgMqgnKCZQEBMwGVLZsRAQF?=
 =?us-ascii?q?5gTGBAYMAgVYUghUWgmSBECgCAQEBAQEBAY4rJ4Ipgz5KgkiCOAUBEgFugks3g?=
 =?us-ascii?q?i4EkGYSgRADggR4ER+BGwEBhieFNYURDBwJEoJVTqkjDgEGAQEngxiLbIwyg1W?=
 =?us-ascii?q?CfQQWMohEjTeEJI0Xi1uHcoJRoSuFEIE/OYENcHCBbi+BHAlIGQ+PRgEBgkqKX?=
 =?us-ascii?q?kEBATE4AgYBCgEBAwmFRhGMHF4BAQ?=
X-IPAS-Result: =?us-ascii?q?A0C0IQAdD6lhT8jrXlJaGwEBAQENAS4BAQEDAwEBAQ4BAQE?=
 =?us-ascii?q?FAQEBCYFbgToCAQEBAQE4WUENIXAxhEeJA4VrgiUijFCJCIZbgWgLAQMBDRICH?=
 =?us-ascii?q?Q4CBAEBhVgBBII2AhoDDDQTAQIEFQEBBQEBAQIBAwMEAQYBARwJEQUDKAEKIoV?=
 =?us-ascii?q?oDYIiEyKEAQETJighHAIYDgI/BgMqgnKCZQEBMwGVLZsRAQF5gTGBAYMAgVYUg?=
 =?us-ascii?q?hUWgmSBECgCAQEBAQEBAY4rJ4Ipgz5KgkiCOAUBEgFugks3gi4EkGYSgRADggR?=
 =?us-ascii?q?4ER+BGwEBhieFNYURDBwJEoJVTqkjDgEGAQEngxiLbIwyg1WCfQQWMohEjTeEJ?=
 =?us-ascii?q?I0Xi1uHcoJRoSuFEIE/OYENcHCBbi+BHAlIGQ+PRgEBgkqKXkEBATE4AgYBCgE?=
 =?us-ascii?q?BAwmFRhGMHF4BAQ?=
X-IronPort-AV: E=Sophos;i="5.87,282,1631570400"; 
   d="scan'208";a="8004031"
X-MGA-submission: =?us-ascii?q?MDFx6PCtR8dH77NO3A2CbcsV4/RhRHKqvGOCN5?=
 =?us-ascii?q?JKPJyyeMPiCTRVSrbAx+mBU0O4czutjCKOx6jKfy6A26x/M26uaxzOR1?=
 =?us-ascii?q?QD3yILtMvKyUj6racwScjlKXrmbk1m4VyW9+84WnSEXGpNJYTVxhHNPb?=
 =?us-ascii?q?D9N4OwYKCPKn8CRasaF1ud3A=3D=3D?=
Received: from mail.proactive.nl ([82.94.235.200])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 19:27:47 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.proactive.nl (Postfix) with ESMTP id 64FAF20A28F2
	for <cocci@inria.fr>; Wed,  1 Dec 2021 06:01:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at proactive.nl
Received: from mail.proactive.nl ([127.0.0.1])
	by localhost (mail.proactive.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7TfvYAlBqtj2 for <cocci@inria.fr>;
	Wed,  1 Dec 2021 06:01:24 +0100 (CET)
Received: from tesco.com (ec2-3-143-214-127.us-east-2.compute.amazonaws.com [3.143.214.127])
	by mail.proactive.nl (Postfix) with ESMTPSA id 5AE7920248D1
	for <cocci@inria.fr>; Wed,  1 Dec 2021 03:38:27 +0100 (CET)
Reply-To: charles.letizia@tescoukplc.com, charles.letizia44@protonmail.com
From: TESCO PLC <charles.letizia11@tesco.com>
To: cocci@inria.fr
Date: 01 Dec 2021 02:38:27 +0000
Message-ID: <20211130203729.7F8811D4DC7A3940@tesco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [cocci] Order Enquiry 12-01-2021
X-Loop: cocci@inria.fr
X-Sequence: 108
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-12/20211130203729.7F8811D4DC7A3940%40tesco.com>

Dear cocci

The most famous brand     TESCO PLC ,   is a British=20
multinational groceries and general merchandise retailer  with=20
over    7,005 shops   and we have currently extended our=20
businesses in 32 top African countries with 436 drop points=20
furnished by Asian     / American /    European & middle east=20
products.=E3=80=80       =E3=80=80

We are sourcing new products to attract new customers and retain=20
our existing ones, creating new partnerships with companies=20
dealing with different kinds of goods globally.     =E3=80=80=E3=80=80

Your company's products are of interest to our market as we have=20
a great market for it.

We hope to be able to order with you and start a long-term=20
friendly, respectable, and solid business partnership.=E3=80=80      =E3=80=
=80=20=20=20=20
      

Share with us your current catalog via email for our review,=20=20=20=20
If    you do have available stock, It will be nice if you share=20
with us details too.

Our standard payment to all our supplier=E2=80=99s globally is on OA=20
basics.

For immediate response Send your reply to "=20=20
charles.letizia@tescoukplc.com  " for our attention only.



Best Regards

Charles Letizia
FCIPS (Chartered) CPO, Group Procurement Director
TESCO PLC=20
Email: charles.letizia@tescoukplc.com=20=20=20=20
 Tell: +44 2885459058  WhatsApp:   +44 7418362780
Website:   www.tescoplc.com
OFFICE: TESCO HOUSE, SHIRE PARK, KESTREL WAY, WELWYN GARDEN CITY=20
AL7 1GA, UNITED KINGDOM
