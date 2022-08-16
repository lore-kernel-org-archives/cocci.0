Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A865C28B2B
	for <cocci@archiver.kernel.org>; Tue, 16 Aug 2022 11:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=X3x8rDOm9hiA7IWBXJzCHy/dqIG5QOowvN1KSBvgFpQ=;
  b=KdjpZq1M0I3bh8sG/B1MRIRx0d6rX28XKcx38qIwniFzNhH3fHWKjOdX
   YBqj3OaUJeJK1aulO/w5GRmjI4PFSpo9ynmNt0qntOZmCqxgoqlRp4Zoi
   q6A4ilCeoMlVcPKaONF7L1Vc9DvdwTIYQ+U5twMaCsp4VRQbuGaqcZ80V
   c=;
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
X-IronPort-AV: E=Sophos;i="5.93,240,1654552800"; 
   d="scan'208";a="48896549"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Aug 2022 13:36:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7D569E0382; Tue, 16 Aug 2022 13:36:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3DDC1E0380
	for <cocci@sympa.inria.fr>; Tue, 16 Aug 2022 10:59:12 +0200 (CEST)
IronPort-SDR: i/gmDYujeOlcWSJn7MOCdUwOfsGfxtsYG02gTVlO7KI7cQyX4X9aJG31/F7JBQPnzPObp8+YBZ
 Q8zrshiqKB+VW16w1Xw+B9ojmJxE12v07pksQ14Uxk6V2X6c+30o6d/CJuJjzCMc4VA6B5hVVF
 kNzC1qHcD8n3fsoIV/KNtSKi67iLXMaBeJk7xmt3Dl0mjL5/Slg1E9vn0pQ3ZhnGVs77rdgRDL
 QrcPFpssLX+g7b9XBPnpwVYxMoW9GpF21deISJfIyqhhg9BICTtPC/NJFkT7TWoHj/pXJgrX/y
 //e5/OYmRxqA5jB24q1gZYXg
X-IPAS-Result: =?us-ascii?q?A0BXJQC+W/tiXUTQVdFaHQEBKwsGAQUFAQIBCQGBZAKBO?=
 =?us-ascii?q?gIBZQcqcTYuBFCEaIhkhkABAQEBAQEGjHYDgQaGGIo+gWgLAQMBCwEBEgEtA?=
 =?us-ascii?q?gQBAUGERoR7Ah0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?AEGHAsJBxIGDw4FYAFhAwFEgU+BTyULAzENgjUig24WIAENARsSCwEDEhBeE?=
 =?us-ascii?q?QEFAQhPgluCbQEDMgMEmniBBEKMRwUXgQGCCQaBFYFMgW4KGSgNZwNbfgIHC?=
 =?us-ascii?q?QEIgSkDAQGGS4NRdYRagRmBEIkMARIBBy84hW4EmQIEBSMDAwIhAwkEBwVKA?=
 =?us-ascii?q?gkDIxEDCxARBw4BFgEECAEEAwEBAQ4CBQcCBgMDAgICAgUBAgoCAQIEAwYGA?=
 =?us-ascii?q?gMQAQIEAQoEAgMIAgcDAgYECgQCBwICBAUDDQEDBQIDAQEDAwIEAQIBAQMIA?=
 =?us-ascii?q?QMCAwMCAgICBQIDAgICCQMEAQcDAgMBBAMBAgoEBAMEAgIHAgcCBAcCAQIGA?=
 =?us-ascii?q?wUGAgIBBwEBBAoEAwMDAwIFAgIDAgYSBgYCBAEDBAIKAgILAgcBAQIBAQEBA?=
 =?us-ascii?q?gMCBwULAQEBAwIDBgUCAQEDCAYCAQQBBQMBBAUDBwIBBQYCCQMDCQMBAQUBA?=
 =?us-ascii?q?wQDAwMCBwMBAgwECAMDAgMEAgICAgEDAgcFCAQCCQICAgECAgYCAQMaAQIDB?=
 =?us-ascii?q?QICCQsBBAICAwEDAQECCAQJBAIDBAIBAQMCAQICAQUCDgYBAQEBAgMDAQIDA?=
 =?us-ascii?q?QYHAggCDg4KAQMDAwICBQICAQIDAgIMAQEEAgECAQIGAQMBAgIDAQMBAgIDA?=
 =?us-ascii?q?gYJAgQBBQMDAgIDAQEFDgUCBAIBAgYFAgEBAQQBAwQEBgICAQMDAg4CBAEEA?=
 =?us-ascii?q?QIBASMDBAIDAQMXAQIBAgMDAwQGBwUCAQITAQIBAQEFAQIBAQMEBAcJAwICB?=
 =?us-ascii?q?AMDBQEBAgMCAQEBBwwCAgITAhMDAQYBDgUUAwIEAgIBAgIKAwECAgEDAgkCA?=
 =?us-ascii?q?QIBBSADAQEPJAEBAgICAgMEBwIBBAYDDQICAQEBBQYNAwIDCA0CBwMCAQMFA?=
 =?us-ascii?q?wICBAECBAoJAQICAQIEBQcCAQgEBQ0FCQsBAQIBAwcEAxECBQMFBQMDAgEGB?=
 =?us-ascii?q?AUCAwECAQEDBAEDBAYBAQIDAgIBBgICAQEDAwQDAQIGAgIHAgMCAQQCAwMBA?=
 =?us-ascii?q?QEEAgICAgIDAwgDAggHBQEGAQIBBAMCAgECBwEEAQgCAQMDBQMEAQoDDwMFA?=
 =?us-ascii?q?wEDAwIUCgUBBQgGCQIEBQIFAwIEAgMDAgIIAwIEAwILAwIGBAIHEwcCAwICB?=
 =?us-ascii?q?QICAgICBQQDAQICAgICAgUCBAIBBQECAgECAgIEAQICBwQCAwEDBA4EBAICB?=
 =?us-ascii?q?wECAgEGAgcDAQIBBAMBAQQCBAECBQIEAQMBAgYCBAMKAgIDAgICBggDAwwJA?=
 =?us-ascii?q?gMFAgYBAQIHBAICCwEGAgcCAgECAxEBAwIBBAUFAwMDCQICAwIEAgIKAQEBA?=
 =?us-ascii?q?QICAQUFAgQHDwICAgQCAgIBAwICAQECAgUECRIBAQIDBgQGBQMCCBgBBgICA?=
 =?us-ascii?q?QECAgIDAwIGAgECCAIEAQQFAgECAgICBAEDBgIDAQECAQICAwMCAQQCBAMDA?=
 =?us-ascii?q?QECAQICAgMCAgIDAgIBEAIGBgECAgICAgMCAgECBgECAQIEAgcCBAMCAQICB?=
 =?us-ascii?q?QICAgMBAQYCBAsBAwIHBgEDAgcFAgMBBAMEAwMFBgUMCAEFAQMBBR8DAgIIA?=
 =?us-ascii?q?gcCAQUDBQEPAwICAwICAQQKAQIDBQIEAgECAQQJBwIEAQINAwMIAgcFGAECA?=
 =?us-ascii?q?gcEDAoCAgIFBgIEAQECAwECAwECAwcCAgMCBAUBBBdNmFslg2VwknCCYo5jn?=
 =?us-ascii?q?RgHAYNUigmVfhoyll0MkgKXAqMJhCcCCgcGECMSgUJRPnAzGiNQMYI2TgECA?=
 =?us-ascii?q?QEBDQECAQEDAQIBAgkBAQKSD4pgPzQ7AgYLAQEDCYVGPoUDAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:41ei566B7n4mPtfHlsKLTAxRtBLBchMFZxGqfqrLsTDasY5as4F+v
 mAXW2jXaf7Za2ejc9lwaYWx/R4Du5/cm95rSwQ/rCFnZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2eaEvfDjW1nX4
 YOr/ZWGULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 I0K5a7hcgkZAvHRid88cxR3KT1GZoQTrdcrIVDn2SCS50jPcn+pzvk3SU9obcsX/eF4BWwI/
 vsdQNwPRkrb1qTmnfThErkq2JRLwMrDZOvzvllizjWJV65gTpHfa6rP7N5cmjw3g6iiGN6CN
 5pGN2U1MHwsZTVseQobF7ACgt3xqSX5YmRFmleY4pYOtj27IAtZieCxarI5YOeiTsJelUewv
 XPD522/AxcANdXZxyDtz563rurGnCe+VY5LUbPmprhlh1qcwmFVAxoTPbemnRWnohb5C+AOE
 EIkxnYzvJMT1EGEdMXFBDTt9RZooSUgc9ZXFuQ77iSExazV/xuVCwA4othpOIxOWCgeFWxC6
 7OZoz/6LWcw7+DNGBpx4p/R/GziY3FERYMXTXZcFVNt3jX1nG0kYvvyojtLFae0ipj4FWi1z
 W7a6ic5gLoXgIgA0KDTEbH7b9CE9sWhou0dvF2/soeZAuVROd7Ni2uAtAez0Bq4BNzFJmRtR
 VBd8yRk0MgADIuWiAuGS/gXEbei6p6taWOC2QM/T8N6qm/9ohZPmLy8BhkudC+F1e5UKVfUj
 LP75Gu9GbcIYSX0Nf4nC25PI517lPG6fTgaahwkRoMWPsIZmP6v8yZpakqdt10BY2B9+ZzTz
 ayzKJ70ZV5DUfoP5GPvG481jOF2rghjmju7bc2ql3yPjOvDDFbIGOdtGAXUMogRsvjfyC2Lq
 IY3Cid/41AAOAEISneHodJ7wJFjBSNTOK0aXOQLKrDac1I3RzpJ5j246epJRrGJVp99zo/gl
 kxRkGcBoLYmrXGYewiMdF55b7bjAcR2oX4hbH4jOF+p3z4oZoP2tPUTcJ4+fL8G8u1/zK4sH
 6NVJZnYWvkfGC7a/zk9bIXmqNMweRmugzWINXX3bTU6ealmWAGUqMTveRHi9XVVAyfu7Zk+r
 rSs2xn1W50GQwg+Xs/aZOj+nVy0tHkZ3ul1WhKQcNVUfUzt9qlsKjDw3qdneZFSdU2by2LDh
 QiMABoeqe3cmKMP8YHE1fKesoOkM+piBU4FTWTW6LCBMyOFrGeuxIl3VvnRIWLQWWbyz6WVZ
 etPysb6PvBazk1BtJBxEuoywK8zu4nvqrtdwlg2FXnHdQ7wWLZpI33D0MUW86MTlvlWvgy5X
 k/J8d5fYO3bNMTgGV8XBQwkcuXTiq1Oy2eKtaw4cBfg+St63LubSkEObROCvypQceluO4Q/z
 OZ95cMbt16lhhwxPorUhyxY7T7XfHkJUqFiu51DRYG12kwkzVZNZZGaASjzucndZ9JJO0gsA
 zmVmKuS2OgGlxSaKyI+RSrXwO5QpZUSoxQWnlUMEFKEx4jejfgt0RwNrDk6Q2y5FPmcPz6f5
 4SqC6F0GUlK1zJhhcwGUmz1Xg8fVFuW/Uv+z1ZPn2rcJ6VtuqohM0VlUdthPmhAm46fQtSf1
 L6dwWfhFz3teakdGwMsDFV9paWLocNZr2X/dQPOIyhBN5Y/aDvhxKSpYALkbvch7dwZ3CX6m
 AWhwAq8hWAX+8LdT23XxrR2DYgtdS0=
IronPort-HdrOrdr: A9a23:Pxc8A64KLoGa0POHHQPXwPnXdLJyesId70hD6qm+c20xTiX+rb
 HUoB1/73XJYVkqKRYdcLy7Scq9qBDnhOZICPcqTNGftWDd0QPCTL2KhbGC/9SKIVybygcy79
 YDT0G8MrHN5JpB4PoSLDPWLz9Z+qj/zElgv4nj80s=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,240,1654552800"; 
   d="scan'208";a="48876724"
X-MGA-submission: =?us-ascii?q?MDHPnoj9tZ6PVNzzsmw3Zu8/lZTNVUb2fK+8E2?=
 =?us-ascii?q?9Yf29mssOpVLitYTZ1Q05NbC2ZFZxyKhvE+8oevgT0RJljOdNaEVz2uc?=
 =?us-ascii?q?HKCH6iwgCY6kC5raObxjga71lE6vR/3UAkRLpv66JKrC18ueyK5Ew1CW?=
 =?us-ascii?q?ipyqyA+C5QOUms58hzO2v76A=3D=3D?=
Received: from mail-ed1-f68.google.com ([209.85.208.68])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 10:59:11 +0200
Received: by mail-ed1-f68.google.com with SMTP id o22so12608755edc.10
        for <cocci@inria.fr>; Tue, 16 Aug 2022 01:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=X3x8rDOm9hiA7IWBXJzCHy/dqIG5QOowvN1KSBvgFpQ=;
        b=WE/61KqYkKzA0Nmun0mAd6um7X+kmUmP8iWacTgvdUwFjRktGtJCn+JS2QXf3yU4gc
         tCoVI2rZj/rH50gax9NEqJaQkWqZhINc7MyciW6L6gS/dj2XtSJo5xgkGTBgC2R0WuA1
         FIc9ic22bRGBEZWwsvROC9cLqVRH0jUaWujp5C1FNbSSt2d/lmt8vmMgfu7DNDBFpz7U
         q8Yi7kzSW73qOc0YlKh05vDUdX7GjWWK9knyXZlW4gxP6YyMSgvvTcrpw7oeg4TWdMlH
         0bblnjsZWOv24zWRx2Cqw8A9GWe8aNaPfLp/cUtn4dQ5AdA7ho9mAzEIvwhPTnEmGHDf
         YzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=X3x8rDOm9hiA7IWBXJzCHy/dqIG5QOowvN1KSBvgFpQ=;
        b=afdC9U03KRtFaax8Um0HaQVV4O3paufGcV6/P6ftOA1SarrmiDPC2I/MMEQS7KsJv3
         EyZNFoxISf6FRbLqYIujl5UipW2eb3zwbE9j0IggaHmswQdudT1Qg0rczZ/UDIROSXRc
         zwGR6NcG3FSszk2xjy0xCn3Q0q+kv9UY5+Zm7di1cp1/it5Kq/6rLPQp5LPhUJvgAJ8X
         ppq7IRnoDAD74/SlDYKAp4MGr0/wRM3N1vR/7NnQn++2zayYKVx0zUFhOccdoowUzRP0
         8zP1q3fuuSOEZdbPSWtzhd2Ns1HS9HGxB/703O21xxSgixATUl8OAQZo1olQFgokF2jX
         M/iA==
X-Gm-Message-State: ACgBeo1RrQBwZSYam0f10niqv7oPGrBWXHa4aGa/Jnzg0lSiGEv1qus9
	0THgQ/FeWirlX0JlOdZOIA6A/NkdjHDuZA==
X-Google-Smtp-Source: AA6agR6iHRfkajG5yRFzInjvEa7wTo1D5lxAh/2nqdr7H1d8BAs9ukslXQ1WtFS5dqb0O6DqfigUYQ==
X-Received: by 2002:a05:6402:194d:b0:43d:8001:984b with SMTP id f13-20020a056402194d00b0043d8001984bmr17762670edz.327.1660640351319;
        Tue, 16 Aug 2022 01:59:11 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id n7-20020a056402514700b0043ba24a26casm8038332edd.23.2022.08.16.01.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 01:59:10 -0700 (PDT)
From: Jakob Koschel <jkl820.git@gmail.com>
To: cocci@inria.fr
Cc: julia.lawall@lip6.fr,
	Jakob Koschel <jkl820.git@gmail.com>
Date: Tue, 16 Aug 2022 10:58:59 +0200
Message-Id: <20220816085859.1546867-1-jkl820.git@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci]  match arbitrary argument position
Reply-To: Jakob Koschel <jkl820.git@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 506
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/20220816085859.1546867-1-jkl820.git%40gmail.com>

Hi,

(resending be cause I accidently included a private email address in cc,
can the duplicate be removed/rejected from the mailing list archive?)

sorry if this question is not suiting here.

I went through the documentation and most of the examples I could find, but wasn't
able to easily answer my question I'm wondering about.

Basically: is there a way to match to *any* argument? E.g. make something match both of
the 'x' uses in the function calls here:

int x = 5;

function_call1(x, 12, 12);

function_call2(0, x);



Based on that I was wondering if there is a way to say: match if the expression is
within an expression list. So if I for instance have something like this:

  @main@
  type T;
  parameter list P;
  expression list E;
  expression E1;
  identifier func, func_call;
  @@

  T func(P@E) {
    ...
    func_call(E1 in E)
    ...
  }

(above is not valid syntax of course)

Ideally I would like to make and get the parameters of 'func' that are used in any position
as arguments in 'func_call' if that makes sense?


Any help is very much appreciated!

Thanks,
Jakob
