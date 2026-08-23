Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D222C5DF94
	for <cocci@archiver.kernel.org>; Mon, 24 Aug 2026 07:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6gZ+stZztq53i2h6dibY3Afk1tu+TwanUQm/4boDBjA=;
  b=IodmLe7653BOcUMu3k3VuU7LLZ1Ole/fZMKBN58V78b22nWsFyRoerY9
   387SaIqM87b5mTI4M6Xxhpqm4mDnI8N5lxlWSRAFsLp4q+bkTTu7Y2sJ3
   aey2ETipj3FI0mWC1I+fMJm1KFD22q98mQfKBdj3IgrcNafnVY7LFENLO
   w=;
X-CSE-ConnectionGUID: byg8+bppSVCORzRdWb+IRA==
X-CSE-MsgGUID: VNq0AbLVQ7i3fxQyQ4GQlg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.25,240,1779141600"; 
   d="scan'208";a="291206982"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2026 09:35:11 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 266BE81696; Mon, 24 Aug 2026 09:35:11 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 853C080527
	for <cocci@sympa.inria.fr>; Sun, 23 Aug 2026 18:18:39 +0200 (CEST)
X-CSE-ConnectionGUID: a53pL/oOQHq84W5oJ2DIaQ==
X-CSE-MsgGUID: AtfZ+TItRVOSGbJRPzgWWw==
IronPort-SDR: 6a8b1d5e_ABDGD4Z59HfzS2y0TGab2p8vSYAAcqaSIjS9EvKzfruU1na
 2Rfj5aAcybdeX3SsK9HnEvbuRlb75W++wlSv4XQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EPCADEHItqfK/SVdFaglkCgj+BCl8zBFSVBwaBPokxg?=
 =?us-ascii?q?hkyjESFXhSBKz0CDwEDAQsBAT0SAgQBAQECAwE4Ag2ENwKNbQIeBwEEMAkOA?=
 =?us-ascii?q?QIEAwIDAQEBAQEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBIhkHDhIph?=
 =?us-ascii?q?k8NSQEQAQQBAYIBAYEkYQIFAzsBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQIsPwEfAgEDMgENARsdAQMMBhA7IAIRAQUBHAYBE?=
 =?us-ascii?q?oMCAYIiAQYQAQM3AgERsT6NBgUCFoEBgg0GgmrYAAoZKA11gWMDAgEGCQEKA?=
 =?us-ascii?q?QGBNwGEdypdA4I8hSN2gxlpeieBGIEQgRWDaYIfgWcjL4YwBIIigQyTWAEHB?=
 =?us-ascii?q?x8SCAEcBggCAkgVEgMEAwQEAQILEwkDAwIOAggDAggGGQE/EgQTAggDBgQLB?=
 =?us-ascii?q?wUfCgIMFAooIhIrCgMqCxIPAw0GBRUBCAYCAgQEAgQMAgkCAgUDBAIEDQMEA?=
 =?us-ascii?q?QEIAgItAwEDGQgJCAILBREYDAsHMQMQCQMfAxQcCEUIBhYBGgYFBgs3FQUME?=
 =?us-ascii?q?QECGwIgBB0RCAMBGwQCAQkDAQMBFQQCFAodAgYIDBcCAgIGAgMDAwoBAggDA?=
 =?us-ascii?q?wMCAxkHBgMEBAEEBAMDAgMFAQMDAwUCAgoGCQEBAQEDAgIIAwcDCgkCBQMbA?=
 =?us-ascii?q?xsFAQICAwIBAggDBwgDDQMEAgMDAwQBAgIBAQECAwEDAwQDAQMDAgEDBwICA?=
 =?us-ascii?q?wMDCwECAwMFAwMFBQICBQUDBQICCgIDAwMCAQMCHAgDBgMSARADAwYBAwcDB?=
 =?us-ascii?q?wIEAwkCCAMDCAgDFwMDBQECAgQDAwgIBAMDBAICAwwFAwIDAwUDAwcCBAIEA?=
 =?us-ascii?q?wMBBQECBwIDBwIBGAMCBAgHBwUCCwQCCAQNCQQCBAICDwQGAwMHAQECAQcFB?=
 =?us-ascii?q?gMCAhABCAoFBgICAhwDHQEDDwYBCQUCAQUOBwUCAhgDBgIDBgUBAwEKCwEBA?=
 =?us-ascii?q?gMKAQIEAgUDAwEDAgMCBgMDAgUFBQMJBwUOCQEDAwYFAgIDAgMBAggEBgUDA?=
 =?us-ascii?q?gIDBQEEAwQDCgMCCAMDCAMLAhoCBQMDAwYJAwcHAgMHAwIFAgcFAwMFAwYBA?=
 =?us-ascii?q?wIBAwMICxUlAwEFAwMCAQMCBQMDGAICBAUDAwMDAwMIBAICAQcGBAICAgEFB?=
 =?us-ascii?q?QUEBQYCBAMIAQEFAwMKDQECBwwDDAYDBwMDBAQDAgUMAgIEAQcGBwcJBwMCA?=
 =?us-ascii?q?wgBAQsEAQMDCgMDBQIBAQcFAwYDBwIDAwMFBAUDAgsDBwICAwMDAikBAQEDA?=
 =?us-ascii?q?wMDAwQDAQMBAwMHAwUDAg4CCAEECQMCBgMHBgMECwkIBwwBPAwHCiQEBAwqA?=
 =?us-ascii?q?RQUBQQlGWcHBwKOXR+CTXsTFBiBfYFRAQEBkhoLkimLe5QmSR4JAQYCYYFng?=
 =?us-ascii?q?QoVCi+MIo8+hXwaM5dTkxkuh2YXkF0jjWeECZFqXYQ+AgoHBxEkEoEyOoFcM?=
 =?us-ascii?q?xojgQFtgUlQAxkPkiOBPspqNTUCOwIHAgcOAwuFXokqgSCBK0lsYAEB?=
IronPort-PHdr: A9a23:CPlLuhH9w/ViD+4lLApIDJ1Gf+NFhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k20hmRBM6CsKwV16L/iOPJZy8p2d65qncMcZhBBVcuqP49uEgNJvDAImDAaMDQUiohA
 c5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/I
 Ru3oAnLqsUanIRuJrs/xxbIpnZFdPldyH91K16Ugxvz6cC88YJ5/S9Nofwh7clAUav7f6Q8U
 7NVCSktPn426sP2qxTNVBOD6HQEXGoZixZFHQfL4gziUpj+riX1uOx92DKHPcLtVrA7RS6i7
 6ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7GcNgEWWROQNpeVy1ZAoO9c
 YQPCfYBPf1FpIX5vlcCsAeyCRWpCO7p1zRGhGL53bci3uohDw/LwhEuEdwNvnrTrtr1OqgdX
 ++uwaXUzjjOde9a1C3h5ITUdB0qvPGCXah3ccrU0UQhChnKjlOfqYD8PT2ayOMNs26G5ORkS
 +2vjGgnoBx2rzexxccshIfJhp8LxlzY6Sl13II4KN6jRU50ZN6rCppQtyWAO4RqRcMiRnhlt
 SAnwbIJpZC1ZjIFyIg7xxHBcfyHdZCF7wzsWuuQPTt1h3ZodbK9ihi97USt1/DxWtS13VtFr
 iRJj9nBu3AN2hHQ9MSKVvRz8Eiu1DuLyQze5eNJLEQwmKfdNpUvzLkwlp8JvkTCGC/7gET2j
 KmMdkUl4Oek8ernYq/gq5SBNIF0khnzProylsG7G+g1MQgDU3KF9eihyLHv51D1TbdKg/Euj
 6XVrYzWKd4fq6KjHgNY3Zgv5wywAjqgzd8Wh2MILEhfdxKCl4XpO0/BIPT/DfqnhlSjijZrx
 /TfMr35DJXBM2HPkLn8cbt/60NQ0gUzzddY55JbDrEOPuj/VVP2tNzdFhM5Mgq0zPj7CNhly
 I8SRWaCDrWaPa7Sq1OE+P8jL/WWaIMIujvwK+Ap5/v0gn84nV8dc7Op3ZwSaH2gAPtmIEuZY
 XTxgtsfDWsGohYyQejphVCZXj5TYmy9X6M45j0hFI2mCoLDSpi3gLOdxCe7AoFWZmdeB1+QF
 nfna5mLW/YXZSKJIs5hlyQEWqK7R48g0xGurg76xKB9Iura4C0UrZTj28Nt6O3JiR4y7SB0D
 9ia02yVUm14hmwISCEx3K58u0Jw0lmM37Vgj/xCC9NT+fBHXB0iOJ7Z1eN6CtTyVhvZfteHV
 VqqW9umDSwzQ98x2dMObEF9G9KtjhDHwSWmGaMal7uOBJAs763c3HnxJ8Nlxnje26cugUcoT
 NdTOGOgnqJw6g3TCJTTk0qFj6ukbb0S0jbC+mub1mqOpE9YXRZqX6jZQH4Re1Parc/h5kPMV
 7CuCaooMg9GycOaMqVEc8Xng1oVDMvkbfbDZ2O400O5Gh+MwvvYTpfuemxb+CzCAUwAuwEV5
 3ePcwYkUGPphWPVCzhnDhrXakft4aEqrnKwSUs91EeSZklgx5K0/xcaw/KGHaA9xLUB7Rwor
 ToxPFu62Zr0Bt2G715sf6tSfIlluA8WhUrWsgV8OtqrKKU01Q1WSBh+o067j0Y/MY5Hi8V/6
 SpylGKaSIqd2VJFLXaD2Izof6fQIS/09QyubKjf3hff1syX8+EB8qdwsE3t6SeuEEdq6HB7y
 59NyXLJ65bEAhdICcqpAxYf+B1zprWcaS44tMvPzXM5CaCvqXfZ3s4xQu4syxKuZdBaZa6HG
 gHvSZVCX5n+AOMvklmtKBkDObMa77Y6auWhcfbOw6u3JKBgkTah2HxA+5x421mQ+jBUT+fJ2
 9Mdzajd0FLYCnHzi1Cuts2xkodBDd0LNky4zyWsRItYZ6koOJ0OFX/rOcq8gNN3m5/qXXdcs
 l+lHVIPnsGzK1KUaBTm0Atc2F5ywzTvkDakzzFyjzAir7aOlC3IzeP4cRMbO2lNDGB8hFboK
 IKwgpgURk+tJwQukRKk4w79yc057OxyLGfdXB0QJ3Cnf0ltV6KxsvyJZMsOoJIkvCNLUfitN
 EiAQ+2YwVNS2CfiEm1CgTEjImvy69Opwlog0TrbdSku/x+7MYlqyBzS5cLRX6tU1zsCHmxjj
 CXPQ0K7NJ+v9MmVkJHKtqa/UXigX9tda3qOr8vIuS2l6GltGRD6keq0n4itHAs03zKhj4EyB
 HXgoxP1Y42t3KO/e7ECHAEgFBrn5sx2F5sr2IYzip8NgyBC3sTF1XUCmGb3d95c3OitCRhFD
 S5OyNnT7g//3URlJX/c3IP1WEKWxc55bsW7aGcbss4kx/hDE7zcrLlNnC8v50G9sRqUe/922
 DEU1fop7ncexeAPogskiCuHUPgeGkxRPCqkkBrtjZj2oaZZanv1KeDohRpWktWoDbXEqQZZE
 Hr0YZYtGyZs4943agqdli2urNu9IJ+JMo9bvwbcixraiulJNJ8985hCzTFqP27wpzxtyuI2i
 wBvwYDvuYGGL2t3+6fqShVcNzDze4YS4mS31fcYzpvQhdn3WMw+R2ZuPtOgV/+jHTMMuO6yM
 g+PFGd5sXKHAf/FGgTZ7k56rnXJGpTtNneNJXBfw88xIXvVbEFZng0QWy0325AjEQX/jsHif
 klkvGhJvg+oghRJw+NscRL4Vy2MwWXgIidxU5WZIBdMu0tP5EnbLJbGtroiTwlX+5SgqEqGL
 WnRNGEqRSkZH0eDAV7kJLyn49LNpvOZCuSJJPzLebySqOZaWqTA1de134Bh5TrJKtSXMywoE
 aggwkQaFyMceYyRi3AVRicQjS6Ic8OLuEL25Hhsts7muPXzBFCwuc3WUeYUaZM3vEnoyaaba
 7zK3Hc/eWsej8lcgyePked6vhZaijkwJWP1Se1S6X6TFPCMyvELXUxcNn07NdMWvfhghlUfZ
 56D0oGphuAk3KxyVgkgNxSpm9n3N5ZUez7vOgPNXBTXZOrad2+Mnp+/YLviG+cA1L0G7BPo6
 2rLTROxbHPeyVyLH1iuKb8e1ijDZE4H5NzlIEo9VzSxHpW7NFW6KIEl1zZuz+86jC6SZzJMb
 2QuIQQQ8PWG5CdcyJ2TAkRn6XxoZamBkiedtazDL4oO9OFsCWJynv5b53Izz/1U6jtFTbp7g
 nmaqNkmuFygnuSVr1gvGBNTtjZGgp6KtkR+KO3Y8JdHQ3PN4BMK6y2ZFR0Lo9JvDtCntbpXz
 5DDk6f6KTEK9Nyxn4NUH8/PNMeOK2YsKzLsET/QSRMLFHulbD6CwUNal/6W+zueqZ174pngl
 ZwSS6NKAVw4EvRJbyYtVNcGIZpxQnYlievB1J9OtSf49kCJApwF48OiNLraG/jkJTeHgKMRY
 hIJxem9NoEPLsjh3EckbFBmnYPMEk6WXNZXoyQnYBVnxScFuHV4UGA33FroLw2353pGX/O3k
 BAr0FMmObV93Djp6lYzYFHNoWFj9St50cWgmj2XfDPree2oWppKDiPvq0UrGpbyQgIwdQPr2
 EI9a2qCSLVWgL9tM2tsjUWP3PkHUe4ZRqpCbhgKwPiRbPh9ylVQpBKswkpf7PfEA59v/OPFW
 ZGppnNEnQlkaYxsTUQ1DKVMx1lUwKmJu33wvgjQ6AoXJkJI6G3LPSBR5xFOOb4hKC6luOdr7
 F7a8wY=
IronPort-Data: A9a23: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
 U7Keg==
IronPort-HdrOrdr: A9a23:mD1yT6oigcauviCi7LnLrtkaV5oPeYIsimQD101hICG9vPbo8v
 xG+85rqCMc7Qx6ZJhOo6HmBEDtewK+yXcx2/hoAV7AZnidhILLFvAF0WKK+VSJcE3DH6xmpN
 xdmsBFaeEYZmIK6foSjjPIceoI8Z2o9OSHi47loEuFjjsHV0ij1WpE436gYzRLrcB9a6YEKA
 ==
X-Talos-CUID: 9a23:xTUDaW3QC5gWSy7JYV/a+LxfE51+almay1DpA1boVVk0T5/PZX6ZwfYx
X-Talos-MUID: =?us-ascii?q?9a23=3AjT0biA9U9wuya4NpDYLB7oOQf+507ZbtNGERq6s?=
 =?us-ascii?q?hgOaOFxZIKTiisyviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,239,1779141600"; 
   d="scan'208";a="291143670"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFK7hISXZOiT594Rc4tOW1yNVN6Ms6DBdQMIF?=
 =?us-ascii?q?NgqvvQtnbsq7+02SviZE8WVMHFkPU9CZjs6WaGc929kEt0SJtNeDeE7U?=
 =?us-ascii?q?gU9yXEhIFlagCMFzkWtXWvdQbVXAuHURncnHAGTnJ6XtFJYpw6Y+n015?=
 =?us-ascii?q?yDpMo5RrU+sta/aOOCrfmsNA=3D=3D?=
Received: from mail-pf1-f175.google.com ([209.85.210.175])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 18:18:38 +0200
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1810711b3a.3
        for <cocci@inria.fr>; Sun, 23 Aug 2026 09:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787501917; x=1788106717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6gZ+stZztq53i2h6dibY3Afk1tu+TwanUQm/4boDBjA=;
        b=QT1r/qXr0H0T8AMrsxE1O1462DIgAq50vHJindsOdY8Xb/0uTxwd0eEnuEcTbdF1qQ
         GGGUK6oYqZwROy7znulq16jBeeG8xAPMYEWUprQHfYjuOxi+dzUYT8PXp4Bz6yVoP5x0
         E6M8h/RKH1V6pFgrug4fQeMTwaQdePbxNC8HjzULPIHChGhIhH5JZyB4GYuUDGLzOmfB
         LMmp6Z621KCsQAP3VP7ic/hJtyYs5D3rSm5m6lGWhhvPUngLF+bBlZ0N4Zl0dvu0hgs/
         pVdsAGErymlZyVz98j99OPELUrTZTI3JsU46CZp4/7VkoxjY3k0p7IOGkyZGplgXrrjp
         5YBA==
X-Gm-Message-State: AFuF++nHjQ8n+D8VKp5dTAnkgX8lvjrrHWDg8ySWjgszl1JYKSu2O9vu
	7pZTeU7ygnY3OBOqwEmyrYNzEatN5Qt3dpjE6EuFDSHpLVeZd5+02CKB
X-Gm-Gg: AR+sD123h1DaUIVcE8Wkv4rVkT5gIs+IW94Ji+A9lf9UEoJfHfhKxr1NnMq5eFyXGVR
	fErXrrVBn3BonCFKpnbdb/nXIJHdpaLzT/8j0qTdFGRGbvNvZCBrVK15UdS/K9UXQQHD1l2OsuM
	IPizNr0URgUolBLz9BLUmectrET14MMK1V0t1QLjiBa5Px2KfQiqAvfmDZ4d42vngWCK7J8ulye
	CEdOzBMvIxFPucipRsU8vzFTrjLIckR3nrZV0Rb2xx6sAtTRkwSGHsnNr5YOmB8CxVGiKb1bUYy
	jALWK3DoypPCwsUzv/CDPGlM/rBzLOcaR58Yu7JhxkuqdAJg8DFcfs2B/TjPFjTOdpdohD71gLA
	gTAphZhf2pHEO+q7VZIuTbon4t77B+OSHE2f+lAc3hd9aKcNnMu3/vzJ9KprwAGdwWqW2liu3fG
	hxvaxOYjQS3KifjAhs6L4MhDqFq9Zr4uURBbxYPsnHmyAgzQVcOQ8qm5E=
X-Received: by 2002:a05:6a20:3d1e:b0:3cc:92d9:80cb with SMTP id adf61e73a8af0-3cd3003b104mr35476195637.12.1787501916924;
        Sun, 23 Aug 2026 09:18:36 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc199dafa1fsm350181a12.3.2026.08.23.09.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:18:36 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org
Date: Mon, 24 Aug 2026 01:18:13 +0900
Message-ID: <20260823161826.3805598-2-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823161826.3805598-1-ekffu200098@gmail.com>
References: <20260823161826.3805598-1-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH 1/7] coccinelle: remove obsolete
 pci_free_consistent.cocci
Reply-To: Sang-Heon Jeon <ekffu200098@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3701
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/0Lg0hKn2ifMky6dj7WOjEA>

pci_alloc_consistent() and pci_free_consistent() were removed by commit
7968778914e5 ("PCI: Remove the deprecated "pci-dma-compat.h" API").

So remove the obsolete script.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 .../coccinelle/free/pci_free_consistent.cocci | 53 -------------------
 1 file changed, 53 deletions(-)
 delete mode 100644 scripts/coccinelle/free/pci_free_consistent.cocci

diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci b/scripts/coccinelle/free/pci_free_consistent.cocci
deleted file mode 100644
index e062b9ba09ff..000000000000
--- a/scripts/coccinelle/free/pci_free_consistent.cocci
+++ /dev/null
@@ -1,53 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/// Find missing pci_free_consistent for every pci_alloc_consistent.
-///
-// Confidence: Moderate
-// Copyright: (C) 2013 Petr Strnad.
-// URL: https://coccinelle.gitlabpages.inria.fr/website
-// Keywords: pci_free_consistent, pci_alloc_consistent
-// Options: --no-includes --include-headers
-
-virtual report
-virtual org
-
-@search@
-local idexpression id;
-expression x,y,z,e;
-position p1,p2;
-type T;
-@@
-
-id = pci_alloc_consistent@p1(x,y,&z)
-... when != e = id
-if (id == NULL || ...) { ... return ...; }
-... when != pci_free_consistent(x,y,id,z)
-    when != if (id) { ... pci_free_consistent(x,y,id,z) ... }
-    when != if (y) { ... pci_free_consistent(x,y,id,z) ... }
-    when != e = (T)id
-    when exists
-(
-return 0;
-|
-return 1;
-|
-return id;
-|
-return@p2 ...;
-)
-
-@script:python depends on report@
-p1 << search.p1;
-p2 << search.p2;
-@@
-
-msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
-coccilib.report.print_report(p2[0],msg)
-
-@script:python depends on org@
-p1 << search.p1;
-p2 << search.p2;
-@@
-
-msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
-cocci.print_main(msg,p1)
-cocci.print_secs("",p2)
-- 
2.43.0

