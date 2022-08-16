Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B275DC2BB41
	for <cocci@archiver.kernel.org>; Tue, 16 Aug 2022 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=NDMNNnnEwpHCGH/II7y7JqeGF8Bdlxn3NTZv0Ftyr4A=;
  b=HA4LapmqgQKyvZk5N0xGUYc18cRSByZz3HCvlrTbc7DX05pKiNWZBX/Z
   tEv79IQ31ECUtG8i4kstCDOHfsdAjS2eZKP+2l/C2fZUE8aHEhZjXb20H
   AgvatSu3dEqIkGCEyh1IJdRpbZrZb7lAgHxjVxg5lLVX4fP+K7KNjsEM/
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
   d="scan'208";a="48896531"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Aug 2022 13:36:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B4EC6E0385; Tue, 16 Aug 2022 13:36:07 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 21782E0380
	for <cocci@sympa.inria.fr>; Tue, 16 Aug 2022 10:54:34 +0200 (CEST)
IronPort-SDR: fmkAL11oeF0NyZdaAI9VMDYkcC5SVLJ1/MLz9n8JiZRjQ0rTMTHqqgYvl1LXCZ8CjBU0EZW/4d
 3gbY+D0OFkI1dDT4bAQTQqLwLNZhCGJ2boswAh5Ard5aLOIQUaRc3dIhGxtWeQqUzBHZrs4SwC
 agWx7g9zZLv0HwcqGIWBdQ2ef4TmnH85T9JZAO7x40zRNoqlMz2H0ytCwuWG5fVXmhHAGKX2Iz
 0Mwv4yUXk/NJ23hOs6fwAxfPuJiGEI5rlqWZ4xkrNKKh6w/1pgBoXAMX/1U6DUi3P8nYFs5Hm/
 fPCtN9XlnWas3ae/9zLz6Hz4
X-IPAS-Result: =?us-ascii?q?A0B9FgDSWvtiXUHQVdFaHgE8DAILgWSCJAcqcTYuBFCEa?=
 =?us-ascii?q?IhkhkABAQEBAQEGjHYDgQaGGIwmCwEDAQsBAUACBAEBQYRGhHsCHQcBBDMGD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQYcCwkHEgYPDgVgAWEDA?=
 =?us-ascii?q?USBT4FPJQsDMQ2CNSKDbhYgAQ0BGx0BAxIQXhEBBQEIGzSCW4JtAQMyAwSac?=
 =?us-ascii?q?4EEQoxHBReBAYIJBoEVgUyBbgoZKA1nA1t+AgcJAQiBLIZNg1F1hFqBGYEQi?=
 =?us-ascii?q?VaGJgSZAgQFIwMDAiEDCQQHBUoCCQMjEQMLEBEHDgEWAQQIAQQDAQEBDgIFB?=
 =?us-ascii?q?wIGAwMCAgICBQECCgIBAgQDBgYCAxABAgQBCgQCAwgCBwMCBgQKBAIHAgIEB?=
 =?us-ascii?q?QMNAQMFAgMBAQMDAgQBAgEBAwgBAwIDAwICAgIFAgMCAgIJAwQBBwMCAwEEA?=
 =?us-ascii?q?wECCgQEAwQCAgcCBwIEBwIBAgYDBQYCAgEHAQEECgQDAwMDAgUCAgMCBhIGB?=
 =?us-ascii?q?gIEAQMEAgoCAgsCBwEBAgEBAQECAgECBwULAQEBAwIDBgUCAQEDCAYCAQQBB?=
 =?us-ascii?q?QMBBAUDBwIBBQYCCQMDCQMBAQUBAwQDAwMCBwMBAgwECAMDAgMEAgICAgEDA?=
 =?us-ascii?q?gcFCAQCCQICAgECAgYCAQMaAQIDBQICCQsBBAICAwEDAQECCAQJBAIDBAIBA?=
 =?us-ascii?q?QMCAQICAQUCDgYBAQEBAgMDAQIDAQYHAggCDg4KAQMDAwICBQICAQIDAgIMA?=
 =?us-ascii?q?QEEAgECAQIGAQMBAgIDAQMBAgIDAgYJAgQBBQMDAgIDAQEFDgUCBAIBAgYFA?=
 =?us-ascii?q?gEBAQQBAwQEBgICAQMDAg4CBAEEAQIBASMDBAIDAQMXAQIBAgMDAwQGBwUCA?=
 =?us-ascii?q?QITAQIBAQEFAQIBAQMEBAcJAwICBAMDBQEBAgMCAQEBBwwCAgITAhMDAQYBD?=
 =?us-ascii?q?gUUAwIEAgIBAgIKAwECAgEDAgkCAQIBBSADAQEPJAEBAgICAgMEBwIBBAYDD?=
 =?us-ascii?q?QICAQEBBQYNAwIDCA0CBwMCAQMFAwICBAECBAoJAQICAQIEBQcCAQgEBQ0FC?=
 =?us-ascii?q?QsBAQIBAwcEAxECBQMFBQMDAgEGBAUCAwECAQEDBAEDBAYBAQIDAgIBBgICA?=
 =?us-ascii?q?QEDAwQDAQIGAgIHAgMCAQQCAwMBAQEEAgICAgIDAwgDAggHBQEGAQIBBAMCA?=
 =?us-ascii?q?gECBwEEAQgCAQMDBQMEAQoDDwMFAwEDAwIUCgUBBQgGCQIEBQIFAwIEAgMDA?=
 =?us-ascii?q?gIIAwIEAwILAwIGBAIHEwcCAwICBQICAgICBQQDAQICAgICAgUCBAIBBQECA?=
 =?us-ascii?q?gECAgIEAQICBwQCAwEDBA4EBAICBwECAgEGAgcDAQIBBAMBAQQCBAECBQIEA?=
 =?us-ascii?q?QMBAgYCBAMKAgIDAgICBggDAwwJAgMFAgYBAQIHBAICCwEGAgcCAgECAxEBA?=
 =?us-ascii?q?wIBBAUFAwMDCQICAwIEAgIKAQEBAQICAQUFAgQHDwICAgQCAgIBAwICAQECA?=
 =?us-ascii?q?gUECRIBAQIDBgQGBQMCCBgBBgICAQECAgIDAwIGAgECCAIEAQQFAgECAgICB?=
 =?us-ascii?q?AEDBgIDAQECAQICAwMCAQQCBAMDAQECAQICAgMCAgIDAgIBEAIGBgECAgICA?=
 =?us-ascii?q?gMCAgECBgECAQIEAgcCBAMCAQICBQICAgMBAQYCBAsBAwIHBgEDAgcFAgMBB?=
 =?us-ascii?q?AMEAwMFBgUMCAEFAQMBBR8DAgIIAgcCAQUDBQEPAwICAwICAQQKAQIDBQIEA?=
 =?us-ascii?q?gECAQQJBwIEAQINAwMIAgcFGAECAgcEDAoCAgIFBgIEAQECAwECAwECAwcCA?=
 =?us-ascii?q?gMCBAUBBBdNnGVwlVKrewcBg1SKCZV+GjKWXQySApcCIKJphCcCCgcGECMSg?=
 =?us-ascii?q?UJRgS4zGiNQMYI2TgECAQEBDQECAQEDAQIBAgkBAQKSD4pgPzQ7AgYLAQEDC?=
 =?us-ascii?q?YVGPoUDAQE?=
IronPort-PHdr: A9a23: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
 4qX/J8=
IronPort-Data: A9a23:lJMLda4b3X2iw5xBZtp5TwxRtBLBchMFZxGqfqrLsTDasY5as4F+v
 jBMDzjVP/yDNmCncop3ady0phtQu5HRmIcySQFr/C48Zn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2eaEvfDjW1nX4
 YOr/ZWGULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 OlqlKG3azU1Ao/BmrwxCQtFPX0uBrITrdcrIVDn2SCS50jPcn+pzvk3SU9oYMsX/eF4BWwI/
 vsdQNwPRkrb1qTmnfThErkq2JlLwMrDZOvzvllizjWJV65gTpHfa6rP7N5cmjw3g6iiGN6CN
 5pGNGs/PHwsZTVTEH49V6hijN33vV7OcS91tA+MhPMOtj27IAtZieCxarI5YOeiTsJelUewv
 XPD522/AxcANdXZxyDtz563rurGnCe+VY5LUbPmq7hlh1qcwmFVAxoTPbemnRWnonKZeu9YC
 X4Ixggjr/Aerl62YIWtZALt9RZooSUgc9ZXFuQ77iSExazV/xuVCwA4othpOIxOWCgeFWxC6
 7OZoz/6LWcw7+DNGBpx4p/R/GziY3FERYMXTXZcFVNt3jX1nG0kYvvyojtLFae0ipj4FWi1z
 W7X6ic5gLoXgIgA0KDTEbH7b9CE9sWhou0dvF2/soeZAuVROd7Ni2uAtAaz0Bq4BNzFJmRtR
 VBd8yRk0MgADIuWiAuGS/gXEbei6p6taWOC2QM/T8N6qm/9ohZPmLy8BhkudC+F1e5UKVfUj
 LP75Gu9GbcIYSX0Nf4nC25PI517lPG6fTgaahwkRoMWPsIZmP6v8yZpakqdt10BY2B9+ZzTz
 ayzKJ70ZV5DUfoP5GPvG481jOF2rghjmju7bc2ql3yPjOvDDFbIGOdtGAXUMogRsvjfyC2Lq
 IY3Cid/41AAOAEISneHodJ7wJFjBSNTOK0aXOQLKrDac1I3RzpJ5j246epJRrGJVp99zo/gl
 kxRkGcBoLYmrXGYewiMdF55b7bjAcR2oX4hbH4jOF+p3z4oZoP2tPUTcJ4+fL8G8u1/zK4sH
 6NVJZnYWvkfGC7a/zk9bIXmqNMweRmugzWINXX3bTU6ealmWAGUqMTveRHi9XVVAyfu7Zk+r
 rSs2xn1W50GQwg+Xs/aZOj+nVy0tHkZ3ul1WhKQcNVUfUzt9qlsKjDw3qdneZFSdU2by2LDh
 QiMABoeqe3cmKMP8YHE1fKesoOkM+piBU4FTWTW6LCBMyOFrGeuxIl3VvnRIWLQWWbyz6WVZ
 etPysb6PvBazk1BtJBxEuoywK8zu4nvqrtdwlg2FXnHdQ7wWLZpI33D0MUW86MTm/lWvgy5X
 k/J8d5fYO3bNMTgGV8XBQwkcuXTiq1Oy2eKtaw4cBfg+St63LubSkEObROCvypQceluO4Q/z
 OZ95cMbt16lhhwxPorUhyxY7T7XfHkJUqFiu51DRYG110wkzVZNZZGaASjzucndZ9JJO0gsA
 zmVmKuS2OgGlxSaKyI+RSrXwO5QpZUSoxQWnlUMEFKEx4jejfgt0RwNrDk6Q2y5FPmcPz6f5
 4SqC6F0GUlK1zJhhcwGUmz1Xg8fWVuW/Uv+z1ZPn2rcJ6VtuqohM0VlUdthPmhAm46fQtSf1
 L6dwWfhFz3teakdGwMsDFV9paWLocNZr2X/dQPOIyhBN5Y/aDvhxKSpYALkbvch7dwZ3CX6m
 AWhwAq8hWAX+8LdT23XxrR2DYgtdS0=
IronPort-HdrOrdr: A9a23:+mZ/vKw5geKobVY/LmmjKrPw4L1zdoMgy1knxilNoG9uEvBw9v
 rFoB1173PJYVoqKRQdcJW7Sc29qBDnmqKdg7N9AV7KZmCP01dAbrsSj7cKqAeAJ8SRzJ8/6U
 4tScZD4IqaNykdsS+s2njeLz7rqOP3iZxBRo/lvg9QpXsBUdAb0+8jYDzrb3GfAGJ9dOQE/F
 /13Ls9m9JlEU5nEvhSwRE+Lpf+m+E=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,240,1654552800"; 
   d="scan'208";a="48875988"
X-MGA-submission: =?us-ascii?q?MDEg4IR8DiVDRe4+5vT0L3g7gsxcVm40V9aGIx?=
 =?us-ascii?q?g2l2RCTZeMDADUFcE3KtJEIsdIfURxUObgjlWpGD2wUYxr23CwH6N22j?=
 =?us-ascii?q?mX5RidCqWuNfQQ+552CNp0JYAtDO4XvxglNvHv/8mp/PGN9EMDctwPyl?=
 =?us-ascii?q?6kzB1lNVDdaWWymgxAW8vAEQ=3D=3D?=
Received: from mail-ed1-f65.google.com ([209.85.208.65])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 10:54:33 +0200
Received: by mail-ed1-f65.google.com with SMTP id b96so12647313edf.0
        for <cocci@inria.fr>; Tue, 16 Aug 2022 01:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NDMNNnnEwpHCGH/II7y7JqeGF8Bdlxn3NTZv0Ftyr4A=;
        b=hxNdWBx59Y3q6VL+aafLoLyeerroh60wf236XJHGzgZoP815mBPsDkHyUH84OFcuub
         /PP/gCSvdu/lwfC6SCT0F9MlW+puHzygDzFJa4K+xLApRI2W9+xN83X0LDfbXYvuafmV
         FVxgwAnxOrCTMvdkfsB0s0vP+XM1HPgJb2dar0QUdJlJiMJHkVRczzbzvjmFUrxNih9R
         XWgtE3SQRS6JHcbjoao5yjPhsNvFHCDPcOiDH2bTwdTARSEX549oWSDw7FfNdHr8Wl3h
         7EUsSn2zlBD2AbU0/pjiwstk+rKmwe6NmVKly3MVp5lCt1O2M/tnD5bDv3pnjqTXhJTk
         a9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NDMNNnnEwpHCGH/II7y7JqeGF8Bdlxn3NTZv0Ftyr4A=;
        b=XKDJvbztqh2nFPplDu2j7JPh7x/yOvPBSyUSKTQwqnIva3jU7rMZqvHsK3odwfa5Qs
         R2/lPjDlIPiIsh9rQQU3fwIL/Upi47avQVuAAWUJGaUWCttYXzpfSwi1ye4PC+8Ux4uz
         rNM0BzWU3Ie06k5Je2vWumPWkQg4ULBJMADR2U2tDI0VsCJjHgXt3EJgrBAWz28OEcRV
         aYWanAxWGgmXv8zUHVNSfJaRnVQNWXSFHdPZVI2uQAwJWSw3lAjspBcluMb7CPs/ypD+
         RJvVZuLAQ4MEjwDrxP5QjycPlpOSshW9gGqNIcXihfz9gSaCgVYS7fZvhXPfLFbkiOXs
         GEuA==
X-Gm-Message-State: ACgBeo2RNDth6dAfFMjSeamMjYzqUz+Wt3AqTapLIjnt+G5s9SuN62qQ
	T2qzjYmK5ueaWZGbMyqbdfeDfV1Ibz6zvA==
X-Google-Smtp-Source: AA6agR4LQGYBGHEDdenBC6BvRKclDu6IFaz/uCNkU1VR1zw+Ll+EbcuoGYvxWSJEQYA4nZXFrVU4mA==
X-Received: by 2002:a05:6402:440c:b0:43a:1124:e56a with SMTP id y12-20020a056402440c00b0043a1124e56amr18353693eda.134.1660640073303;
        Tue, 16 Aug 2022 01:54:33 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id 1-20020a170906300100b006fee98045cdsm5158424ejz.10.2022.08.16.01.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 01:54:32 -0700 (PDT)
From: Jakob Koschel <jkl820.git@gmail.com>
To: cocci@inria.fr,
	jkl820.misc@gmail.com
Cc: julia.lawall@lip6.fr,
	Jakob Koschel <jkl820.git@gmail.com>
Date: Tue, 16 Aug 2022 10:54:16 +0200
Message-Id: <20220816085416.1542114-1-jkl820.git@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci]  match arbitrary argument position
Reply-To: Jakob Koschel <jkl820.git@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 505
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/20220816085416.1542114-1-jkl820.git%40gmail.com>

Hi,

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
