Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B66FC433FE
	for <cocci@archiver.kernel.org>; Sat, 22 Oct 2022 12:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lHwu9GXPxV+ATNKZpDmfy1T0ENJUhYkXfOysBox0Xdc=;
  b=aZSqyIfjRvFxN1HHEMZSoRiJ1YrzkjVtGVUqXyZ2yRZXpNpzkMUqBQB3
   ACZUqO4KOtwlDO38ArWABIQKh6rq0Wu0b2wMCuHWwDjWQsPo+GVeMux0C
   JJ+UlHna1z06QaJgsuW53s0cC/4XsCJH1acGwSo68eRegRYkM7POsITTy
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.95,205,1661810400"; 
   d="scan'208";a="67870385"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Oct 2022 14:45:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 78B93E01D1; Sat, 22 Oct 2022 14:45:05 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8B7BEE004E
	for <cocci@sympa.inria.fr>; Sat, 22 Oct 2022 14:45:01 +0200 (CEST)
IronPort-SDR: 6353e5cd_Pp/XfkydjR0m3nHV+FS2mwWwSMlSNnB/Du/Z5miq2oM/+op
 txG3z8X8vYauwI8/13z+wvrq3keC0f333avQMmg==
X-IPAS-Result: =?us-ascii?q?A0AoBADS5FNjfyyAVdFaHgE8DAILFYFPgi2BBFMuBFCET?=
 =?us-ascii?q?pxbgQeGIoo0gXwPAQMBCwEBRAQBAYUFAoRxAh0HAQQxCA4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAETAQEYCRkHDg4FJIVoDYI1KQGDZAIBAxIRH?=
 =?us-ascii?q?QEbHQEDEgULDwImAiURAQUBHAY1hUgBAzADBJ5TgQRCizKBFQUCFoEBggkGg?=
 =?us-ascii?q?mKBbQoZKA1oA4FaAgcJAQh/LIhfhwJ6JxyBSUSEPz6EWYNCgmYElT0BAwUUD?=
 =?us-ascii?q?wMDAiEDGSsdAgkDIw8DCwkIExcoBgMBAQwHRgQcHwMBAQ8kAQECAgIDBAcCA?=
 =?us-ascii?q?QMGAwwCAgEBAQUGDQMCAwgBEgMCAQMFAgIEAQIECggBAgIBAgQFBwIBCAYFD?=
 =?us-ascii?q?QUJCwEBAgEDBwQDEQIFAwUFAwMCAQkBBQIDAQIBAQMGBAQBAQIDAgIBBgICA?=
 =?us-ascii?q?QEDAwQDAQIGAgIHAgMCAQQCAwMBAQECAgICAgIDAwkCCAcFAQYBAgEEAwICA?=
 =?us-ascii?q?QIHAQQBCAMDBQUJDwMFAwEDAwIUCgUBAwgGCAIEBQIFAwIEAgMCAggDAgQDC?=
 =?us-ascii?q?wMFBAIHEwcCAwICBQICAgICBQQDAQICAgICAgUCAwIBBQECAgECAgIEAQICB?=
 =?us-ascii?q?wQCAwEDBA4EAwICBwECAgEGAgcDAQIBBAMBAQQCBAECBQIEAQMGAgQDCgICA?=
 =?us-ascii?q?wICAgYFAwMKCAIDBQIEAQECBwQCAgsBBgIHAgIDEAEDAQQFBQMDAwkCAgMCB?=
 =?us-ascii?q?AICCgEBAQECAgEHAgQHDwICAgQCAgIBAwICAQECAgoSAQECAwYEBgUDAggYA?=
 =?us-ascii?q?QYCAQECAgMDAgYCAQIIAgQBBAUCAQICAgIEAQMGAgMBAQIBAgIDAwIBBAIEA?=
 =?us-ascii?q?wMBAgECAgIDAgICAwICAQ8CBgYBAgICAgICAgICAQUBAgECBAIHAgQDAgECA?=
 =?us-ascii?q?gUCAgIDAQEGAgQLAQMCBwYBAwIHBQIDAQQDBAMDBQYFDAgBBQEDAR4DAgIIA?=
 =?us-ascii?q?gcCAQYFAQ8DAgIDAgIBBAoCAwUCBAIBBAkHAgQBAgkDAgYCBwUYAQICBwQMC?=
 =?us-ascii?q?gICAgUGAgQBAQEBAwECAQECAwQCAwIEBQEFAgECBQQCAgEBAgUCDAECAQcGA?=
 =?us-ascii?q?gcCAgICAwEEAgECAQMDAgMBAQEDBgYFBAQCAwMGAgICBgICAwISAwYCBgMCB?=
 =?us-ascii?q?AENDwUEBQgBAgEBBwIEAgcJDgIBBgEFAgIDAgIBBAECAQYDAQICAgIFCAUDB?=
 =?us-ascii?q?AUDCQwDAQEEAwIBAgEEAwIDBwMCBAQDAQIDBAYGAQkDAgIGAwICAg0DBAICA?=
 =?us-ascii?q?QIBAgMEBAYCAgIBAgICAgMEAgIBAQMDAwICAgMEAgMDCwYKCAICAgMCAQULB?=
 =?us-ascii?q?AIDAgEDBgkCBAICBgECBAICAgICAgIDAQEDCgQCAQIDAgIGAwYCAQIBAgEJB?=
 =?us-ascii?q?QIBCQMBAgECAQQBAwYEAQICBAkCAwcFBAYEAgICAggCAg4DAwIBAQQCAgQFA?=
 =?us-ascii?q?gILAgECBwIFAQEDBQcCAgECAgEEAwEJBAECAgMCAQEDAxEDAwMBBAICBQMDD?=
 =?us-ascii?q?QkGAgIBAwIDAQ0DAwECAQIDAQUFFwMCAQgHAxMDAgEBAwIBAgIDBgQBCAICA?=
 =?us-ascii?q?wMDAgECBQIEAwMBBQIBAQMBBQMCDgMCAwMDAgYBAgEBAgMCAwEMBAUBAQEBF?=
 =?us-ascii?q?gMBAgMCBAICAQECCAEEAwEBAgECAwICDgYBBAWcRsJwY4MJoEcyg2QBEoxSh?=
 =?us-ascii?q?iEUkhOXIadLAgoHBhAjEoEvATeBW00jFWyCNk4DGQ+SEopgPzQ7AgYLAQEDC?=
 =?us-ascii?q?YpVAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:wRZov6NG73w0t8BcTuyjsMiBIKoaSvp037Dk7TEXdfUzSL3iqy
 nOpoVi6faQslwssR4b6La90cW7MBbhHNtOkPAs1NSZLXTbUQmTXeJfBOLZqlWKexEWntQ96U
 4KSdkdNDSfNykfsS+32njDLz/i+rW6GWKT6Ns2A00DceiiUc9d0zs=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,205,1661810400"; 
   d="scan'208";a="67870377"
X-MGA-submission: =?us-ascii?q?MDEnSW/nJJ18T8wV/vvkzpT6UmWl8wC2t0xLFl?=
 =?us-ascii?q?h3awKEa3LdKPTVGYE9Ant5z2fWT5v3X3T0wCh4fek9pytRkMXWY1oWSV?=
 =?us-ascii?q?z8cHZx3OBCbbbPf2E3EohGSCKMVjo4JknLKbicgII9OWCbpE3h7s0+aL?=
 =?us-ascii?q?xn9OgIUqVI1i+MooSZSaFyoQ=3D=3D?=
Received: from mail-wm1-f44.google.com ([209.85.128.44])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 14:45:01 +0200
Received: by mail-wm1-f44.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so6933964wma.3;
        Sat, 22 Oct 2022 05:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHwu9GXPxV+ATNKZpDmfy1T0ENJUhYkXfOysBox0Xdc=;
        b=c5glDMyomCqLEI1o+XRaonlUxGY9cuTzR2Yx2JBmaQ5qO9nCtnFEJeRUmrXl/x7R4Z
         qh7Yro5bmQoCpEOpd1k0XPTjRDocl8mFMS6Gg+18B1DavlYVzdkp01Xs/gOYbAZZD30x
         DYI/T2pqzHqEBQS/AYDgxweP4h1KkecQRliAN/9BJ6TgDpW5/QsOHAp+A6oFJBtzL+AB
         xGVW0OWOs0UU+NvU1e9SeoomaRL4kdkSyFKLO1RYbO7a8o+nAdsZzL+pNgndSwXpIrh6
         w0VlBWeRCJgA3TEXxj5umeGph07qMR797FQJ4z5Q/x/hE4EPI0rAa55Gsw/0n3JYZE57
         ZRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lHwu9GXPxV+ATNKZpDmfy1T0ENJUhYkXfOysBox0Xdc=;
        b=ppfH8S8dYDJZKkS3ABzgZZaaH66/vsaf7tBDcqr1uqZ9C+s5ZYLdp55JsaoJft4tJn
         9LrptiVULWrHEF8ai5T23WJx6iHdtmAIBMnqiqWiezdvDkFjH6IPSILExcgP7vchekbO
         FrC+nObLeVa2FWbsQLg1kErw26YR/o0sMUDSBr6O/UkeVxP3VsBoqDm9RbnG9BHmiXti
         Cnbmt7NyW/8d15lWH8LAQuBzm1G1x+YhXPh1uq5UPDJ69hWJEh9d57XynuJhSAVWpllA
         gChsC0jWwPLuByqhrELHTV38MnSBrlUlideaxPW9LsmYgvzhSC+H2PPjGi0tN60VXSVr
         qpdg==
X-Gm-Message-State: ACrzQf2vCsp9hiLTJPF1zoVoo5bfEXPgQTJCwENMfokaSpWV1eGSgRdy
	mm7u2s8ZPhyzu9BPEUJPKRlMtlVM84o=
X-Google-Smtp-Source: AMsMyM6zPdDyEBo0mKHZsJWYgr6VT3XIzxPUUP75npsMntfkbKq+WnikvneoWI3T3cNBBlwvow6+rA==
X-Received: by 2002:a1c:cc11:0:b0:3c3:9576:eb47 with SMTP id h17-20020a1ccc11000000b003c39576eb47mr16006943wmb.96.1666442700744;
        Sat, 22 Oct 2022 05:45:00 -0700 (PDT)
Received: from [192.168.1.191] (ip-89-177-205-85.bb.vodafone.cz. [89.177.205.85])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003c43dc42b4dsm2548812wma.16.2022.10.22.05.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 05:45:00 -0700 (PDT)
Message-ID: <7691aca779054e7e2145d01bd95ff02a00a9da0a.camel@gmail.com>
From: Jan Tojnar <jtojnar@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Date: Sat, 22 Oct 2022 14:44:59 +0200
In-Reply-To: <20220903093843.2579539-2-jtojnar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.0 
MIME-Version: 1.0
Subject: Re: [cocci] [PATCH 2/2] Distinguish script-based fresh ids with
 differing args
Reply-To: Jan Tojnar <jtojnar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 668
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/7691aca779054e7e2145d01bd95ff02a00a9da0a.camel%40gmail.com>

Hi Julia,

Could you please review the above patch, when you have time? It fixes
the regression in `fresh identifiers` in conjunction with scripts from
master.

Cheers,

Jan
