Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D41E9B252
	for <cocci@archiver.kernel.org>; Tue, 24 Feb 2026 11:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=4DstXTFOjjOc95Qmzr+SeIQriKKg0cVXhchBEqikS0w=;
  b=PoHvv0zah4Vkgqd9RPObo5qjX38ML7KAsSawlFS8U64v0TNGj+bBR6e9
   EJmNpWG/Y0RIyF3fwQDJ/asolX/dR6SBoKsn4CMyRcDY50q7DdSzVoVpf
   5Cma0ueN0CncbKbIYI/Y+kqlDnigvd46PknGRrNICL3Rn9mJWn0mWEyny
   M=;
X-CSE-ConnectionGUID: LJWWrJmZQMSmzJ5F/4Ip4A==
X-CSE-MsgGUID: yluPjTxGRO62I5Tco4MzYA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,308,1763420400"; 
   d="scan'208";a="264908195"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Feb 2026 12:04:53 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8CA8B83681; Tue, 24 Feb 2026 12:04:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 3C02880F68
	for <cocci@sympa.inria.fr>; Sun, 22 Feb 2026 23:56:09 +0100 (CET)
X-CSE-ConnectionGUID: K5lydY/3QJmRIrSOW+/lmA==
X-CSE-MsgGUID: rO59ER2xRdy5ltQ82wkAOQ==
IronPort-SDR: 699b8988_guK+6kjoSReTLZlPc/45kbDV3fjwpCtYiSPgz4GL5AcqXB1
 5fmzcZ5T5BX9OY0uvemiH3NXLt6Sga60H6Qr78w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HQAgA3iJtpfK2AVdFaglkCgj8WgVAzBFSiRpIjgUA9A?=
 =?us-ascii?q?g8BAwELAQFPAgQBAQMENwGESI0iAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?QEBDQEBBQEBAQIBAQIEBgECEAEBIhkHDhIphk8NSRYBgXtgTGECBQM7AQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQoCLGEWIAENARsEGQEDEhACI?=
 =?us-ascii?q?wwqAhEBBQEjCggigmCCIwEGEAEDNgOcfYEFQoxTBQIWgQGCDQZS2hMKGSgNc?=
 =?us-ascii?q?YFhAQICBwkBCgEBgTcBhHYpXQGCN4UgdIQAgSEbgg2EDm+CH4I5OAOFUiIEg?=
 =?us-ascii?q?iJ6FI1/B4VCCAcfEggBHAYKAkgVEgMEAwQEAQILEwkDAwIOAggDAggGGQE/E?=
 =?us-ascii?q?gQTCgMKCwcFHwoCDBQKKCISAikKAyAKCxIPAxgVAQEHBgICAwEEAgQMAgMBB?=
 =?us-ascii?q?QICBQQDAgoEAwMEAQEIAgItAwEDGQgJCAILBREYDAsFAgonAw8BCQMfFxkIA?=
 =?us-ascii?q?UUIBhYBGgcFBgs4FQcKBAICAQUFAgEBAQwJAgICBwMOAwICAgMEAQIDBAMFA?=
 =?us-ascii?q?gMEAQEBAQQFAgMDAgIBAwUCAgEBAgIEBAIDAwYCBAIOAgEFHREBAgYFAwIBA?=
 =?us-ascii?q?wUDAwMDAwIEAgICAgYHCwwEBAQDBQMDBQYDAQMEAwgDCgIEGAYFAgICAQIMD?=
 =?us-ascii?q?wMDCgQEAwIFAgYJAwIDAwQBAzkcEwQFAgUDAwE6Aw4EAwgGGAIBAQIGAgEDA?=
 =?us-ascii?q?wgCAwEDAgcDFAYBBggCBAQKAgMDBwYFBwIRKAQCAgICBAMDAwoHBwQDAQcDA?=
 =?us-ascii?q?wwCAhACBAQCFAMDBAMQAwECEhgGAQMHCAMCBwQWAwIJGQQCBAMCAgICAS4DB?=
 =?us-ascii?q?QcCBAECBgEDAwcDAgwCAgISBQQGAgEDDAMEAwUFCy0RBxMKBgQHBQICAhQGA?=
 =?us-ascii?q?gQMEgMDBAQCAQICAjoECAwaDgQIBwMHARgFAgMCAwUBAwEHBxICCggDDh4BA?=
 =?us-ascii?q?wIGAgkBAQoPAgICBAICAQMIGAMEHwQDAwcCAgwJAwQRAgUFCAcKEhsDDgMNF?=
 =?us-ascii?q?wcEAwwKMAsOEw8DCwkIBwwBPAwHCigENgEGDhQHBCUZZwcHjh0/gjSBDoFHl?=
 =?us-ascii?q?3OMcYIeoCBxaIM+m1yFfBozl1KTGZkGIpFwkkeEPQIKBwcRJBKBMjqBXE0jU?=
 =?us-ascii?q?DGCNk8DGQ+OX4NCuxk7NTwCBwsBAQMJhUMmEwuKI4FmDoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:438x1KqQcVsYCaluf8d86su4DKpeBmIzYRIvgKrLsJaIsI4StFCzt
 garIBnVb/nbMDajKYwlbNviphgHu8LTz4dnS1NkrS40QX5H8OPIVI+TRqvSF3PLf5ebFCqLz
 O1HN4KedJhsJpP4jk3wWlQ0hSAkjclkfpKlVaiZfHk3HVI5IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bNNwRcawr40Ird7kk21BjOkGlA5AJmP6oR5Aa2e0Q9VfrzG4nhdxMUfaEPRoZWd
 86bpJml82XQ+QsaC9/Nut7Tbk0QT7fOChOFg3xQVrLKqkAqSvsaj87XnNJFAatmo23hc+JZk
 L2hhrTsIesdBZAgrcxGO/Vu/46SCoUdkFPPCSDXXcV+VCQqeVO0qxllJBle0YH1Zo+bqIyBn
 BAVAGllU/yNuw656JHmTvhgt4N4FevuBqIFgVZfjnbdCN9zFPgvQ42SjTNZ9DI5h8QLDOmHI
 sRANmEpYxPHbBlCfFwQDfrSns/y3ii5I2Ae8QjF4/NouAA/zyQpuFTpGMfTe8yARcxOnU+Cj
 m3D9mX9RBodMbRzzBLcqSPw17+UwnKTtIQ6Dprlp9NQ2k2pyn1ODAEvBQGkotCesxvrMz5YA
 xdJo3Jx/PZaGFaQZtL6VBa5iGWVuwYVHdtWCewzrg+Xopc4+C6cD2kACy9eMZko7ZBtAzMt0
 VCNkpXiAjkHXKCppWy11eqQvD+DfnMsD2o4RDU/ajRGpN3midRm5v7QdeqPBpJZmTEcJN0d6
 zWDrSx7lqpKyMBSiP798lfAjDah4JPOS2bZBzk7vEr8tlsRiG2NPtPABb3nARBoct/xor6p4
 iNspiRmxLpSZaxhbQTUKAn3IF1W2xp1GGaB2AYwTsdJG8WF9HmkcoRdqDB4LwEBD/vojQTBO
 ReJ0SsIvME7FCLzMcdfPdjtY+x0lvOIPYq+Bpjpgi9mOMQZmPmvpnw2PRb4MqGEuBRErJzTz
 r/CLp30XSxKUf82pNd0Ls9EuYIWKukF7Tu7bfjGI96PiNJyvVbMEe9fYmidJPs09r2Fqwjz+
 tNSfZnCgRZGXeG0JmGd/YcPJBpYZTI2FLLnmfxxL+SjGwtBHH1+Kvnzxbh6RZdpsZ4Incj1/
 1a8eHRi9nzBuVP9Jz+3N09TMIHUYc4nrFYQHzAdAlKz6n1yPaet9Pg+crU0T5kG9cti7/h+c
 Ncdce7dAP4VEjXj0BYeZKnbs4ZNWkmKhwWPHiz9exk5XcdqaDLo8+/eXDnE1XcxHAvukuAh+
 Zuy1Rj+Q6sTYyhHE+DoMOmOyXG1tlgjwNNCZVPCeIRvSR+94bpUJDzUpd5pBtMHNjHo5CaQj
 iSSCjcm/dj9mZc/qoT1tPrVvrWSMrVMG2RBFDPm9pewDy7R+1SjzaJmUOqleTP8Vnv+yJ69Z
 Nd6nu3ND/kaoGlk64ZMMa5n7aYb1evdo7V3ygdFHnKSS3+JDrhmAGeN3OgRl6lr64JahzCLW
 RO0yoEHAYmKBcLrK05OBQwHau/Y6+oYtAOP5tsIIWL7xhRNwpy5bWtoMSKhtglhPZpuEYZ8w
 e4eqM8csAO+rRwxM+e5tCNf9kXSD3lZU6wYqY0XMIT7rjUa2ndQRIHuUH7o0sufb/FJFFcgG
 R6Ppa/4n78H7FHzQ3kyMnns3ORmmpUFvi5R/mICP1ikntnkhOc9+R9srQQMUQVeyytY39JJO
 mREM1N/IYOM9WxKgPdvcn+NGQYbIjGk4W30lkU0kVPGQ3mSVmDiKHM3PcCP9hs790NeZj1qw
 6GK+l36UDrFfNDD4QVqYBRL88fcdN1W8hHOvOuFHM7fRpkzXmfDs5+UPGENr0PqPNM1iEj5v
 tJVxedXa5DgFCsusqY+Wpi717MRdUi+H1Z8Y8pdpYEHIWKNXwuJ+2mqC1uwccZzNfD14ReGK
 8hxFPluCTW69giz9w4+O4BdAoVavvAT4Pg6RojKPk8D6ruWkSpousnf9w/4n24afO9tmsccd
 KLUey6zLWiLoX5yhWX2jdJlP1CgaoIufzzM3+GS8cQIGakcsepqT1oA77uss1iRMypl5xixv
 j6fQ4PnlMtZ1pVKnab3N7dqXjWPNtL4UdqX/DCJs9hhac3FNeHMvVg3rmbLEht3P7wDfcZej
 pWI7cDK2X3asIYMU2z2n4eLE49L756QWMtVKsfGE2lIrxCdWcPD4woxxE7gEMZnyOhi38iAQ
 xe0TOCSdtRPAtdU+yBzWhhkSh0YD/z6U7fkqSaDtM+zMxk60zHcDdaZ5HTsPHB6dCgJBsXEM
 TXKmc2Sv/JWkIcdIyU/JaBWM8ctahurE64rbMb4ujSkH3GlyAHK8KfrkR07ryrHED+YGcL9+
 ojIXQX6aA/0gqzT0dVFqMZni3X71pqmbTUYJSrxOuKaigxWyEYDJOUZdIQZU9Ray3Opkp7/Y
 z7JYS0pDiCVsfGot/njyIyLY+tdLrVm1hTFyvgB8EadaiPwD4SFaFek3jk1+G94I1MP08n+Q
 ezzORTM0tyZzZRgROJV7fu+6QuiKjU22VpQkX3AfwfO79ryzFnEOLGN3OaAaMAfL/zwqQ==
IronPort-HdrOrdr: A9a23:VbeYwq4cIinGDPWBQAPXwBvXdLJyesId70hD6qm+c20wTiX+rb
 HVoB1/73XJYVkqKRcdcLy7Scu9qBDnhOVICOsqTM6ftWDd0QPCXeJfBOPZowEIcBeOkdK1u5
 0QFpRWOZneC0Nlhd327AT9P9Er28mf7ayk7N2z815dCS9vL49vhj0WNu9ZKCJLrct9aKbRbK
 DsnvavbgDARUgq
X-Talos-CUID: 9a23:WcrKkWBf026uKXH6Ewo68F8YK4d+S1/Y9lbKGGiHSiFtTZTAHA==
X-Talos-MUID: 9a23:uOBFoglG8nv1pzmQGqsudnp4E5o5zp70GHoBgMgCp/DUbzNzEhCk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,305,1763420400"; 
   d="scan'208";a="139498379"
X-MGA-submission: =?us-ascii?q?MDFE21Fk8SCx1ruKSacYb8FY5Wp0xlFFaH4jCP?=
 =?us-ascii?q?CPAisL0SW23+mmL2qhshlCKXjUD6dHYOPB/bgJ8sm0e7S6rITr2vYyI6?=
 =?us-ascii?q?EFpDbBYiYakn8bNRtlMGrKRke9h5EsuBF2bHgJ4+lZHa7LKXfue9rJWM?=
 =?us-ascii?q?3VxiHsbneSZG/T/+EDQFChsg=3D=3D?=
Received: from mail-yw1-f173.google.com ([209.85.128.173])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2026 23:56:09 +0100
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-794f701a3e6so35086107b3.2
        for <cocci@inria.fr>; Sun, 22 Feb 2026 14:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771800967; x=1772405767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DstXTFOjjOc95Qmzr+SeIQriKKg0cVXhchBEqikS0w=;
        b=wQ+ecjUoIYkzFoQTHpB8RuM+uLaOrb3kOJo+Zf54g17en0jeG+HtRvJrvEN5WbdMZR
         zDa/JN+xndfTs9xdl0Pi+U4StqeSNGD0Rio9frs9seZelI95bSsa1gLqWEf7f24ddZd5
         3PUxgce7PmwCLjOVYN0suHUlufMbsr0yf/6O/XzNvarQwXrpg8Wt2w25uSEEL92IVAyH
         R93mLmI3fKsvTM1dXyJh7xI9YMVDQfKO4AXN/L8NzcVlA7v9/sK0QvhDYs8vaLVnCh72
         bVDU/JAMfJJuC1q407ZuTVMuEmua9VTKraUmHpKgTfKCpgI1dIc7DCsnCAq/VAMmSRez
         zAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm5V/efrUDStJsV4kGCzxLo48phU2jvmG9ByfU5x2DYos6C6NQFz0JfgVlHMksQHDqefMJrw==@inria.fr
X-Gm-Message-State: AOJu0YwsH64MsBr1un5gYjwpauveAt7CG7MHvlEFJmNXW0SdoEfdzDSu
	nEaJSyVcos6aTv6AtHqv6VKavx6LLLlyD6yZgIppsakAYcvrCigO3JOi
X-Gm-Gg: ATEYQzzOBSc1U+61AhaldarnXNVXDEq8hAwkItVEEfEPH/0hU4e3JwD6yg2rPOVNNFf
	cmHVWbsGgyhW9DqQPp9qcQnWyZnVV00yk/w6Yt7+2DuXbhL3LsX8UU81pUfDdDku9uxgPOF/Ccr
	NNocc47oKV4CJJeerP10cD+2QHDh1rzpgMGBy+HVNMb+sUX9hZvXxfphQz+uWxPa9+cuEu4ccH/
	fjh1cQKT4HvBLAq3L2Gv0zt+ZUY9vWB7DX9amIWISKekEBvenlCT9a/Y5CMz8tr60DpwaZ/+EZF
	birXOBFuLeiXas7rytdz2DUP2eJM1H4bhNYxJCmcwNPXiPg8HhLYkJ0YV7hvt5NxE3m5pIMV+tB
	cdJh5rGyZP/JDG6+Dzp3b/cgrA5Z6FqojKcOUeyvTJnFZY1+4SJ/hM3j6yc62zp22BJK6pZIisS
	RLiEVDgcoeZNYHzS4lVoo=
X-Received: by 2002:a05:690c:2701:b0:798:1adc:6804 with SMTP id 00721157ae682-79828ff1c5cmr56780367b3.43.1771800967149;
        Sun, 22 Feb 2026 14:56:07 -0800 (PST)
Received: from Gentoo ([158.173.25.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982de1a659sm24518477b3.52.2026.02.22.14.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 14:56:06 -0800 (PST)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: Julia.Lawall@inria.fr,
	nicolas.palix@imag.fr,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	cocci@inria.fr,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Date: Mon, 23 Feb 2026 04:19:56 +0530
Message-ID: <20260222225536.19196-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: [cocci] [PATCH V2] Doc: dev-tools:  Added Gentoo in the Operating
 system list under Getting Coccinelle
Reply-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3311
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-02/iKBfjgM3rLtENiJWGXSA6Q>

 Adding Gentoo in the operating system list under "Getting Coccinelle".

 This is the correct way:

 Example:

 bhaskar_04:20:50_Mon Feb 23: :~>sudo emerge -av dev-util/coccinelle
 Password:

 These are the packages that would be merged, in order:

 Calculating dependencies... done!
 Dependency resolution took 7.99 s (backtrack: 0/100).

 [ebuild  N     ] dev-lang/ocaml-4.14.2:0/4.14.2::gentoo  USE="-emacs -flambda
 -latex ocamlopt -xemacs" 5377 KiB
 [ebuild  N     ] dev-ml/dune-3.20.2:0/3.20.2::gentoo  USE="-emacs" 2981 KiB
 [ebuild  N     ] dev-ml/findlib-1.9.6-r1::gentoo  USE="-doc ocamlopt -tk" 265
 KiB
 [ebuild  N     ] dev-ml/result-1.5:0/1.5::gentoo  USE="ocamlopt" 3 KiB
 [ebuild  N     ] dev-ml/sexplib0-0.16.0:0/0.16.0::gentoo  USE="ocamlopt" 22
 KiB
 [ebuild  N     ] dev-ml/ocamlbuild-0.15.0:0/0.15.0::gentoo  USE="ocamlopt"
 198 KiB
 [ebuild  N     ] dev-ml/menhir-20240715:0/20240715::gentoo  USE="ocamlopt"
 1217 KiB
 [ebuild  N     ] dev-ml/num-1.5::gentoo  USE="ocamlopt" 67 KiB
 [ebuild  N     ] dev-ml/camlp4-4.14_p1-r2:0/4.14_p1::gentoo  USE="ocamlopt"
 627 KiB
 [ebuild  N     ] dev-ml/csexp-1.5.2-r1:0/1.5.2::gentoo  USE="ocamlopt -test"
 12 KiB
 [ebuild  N     ] dev-ml/uchar-0.0.2-r1:0/0.0.2::gentoo  USE="ocamlopt" 22 KiB
 [ebuild  N     ] dev-ml/dune-configurator-3.20.2:0/3.20.2::gentoo
 USE="ocamlopt" 0 KiB
 [ebuild  N    ~] dev-ml/stdcompat-21.1-r1:0/21.1::gentoo  611 KiB
 [ebuild  N     ] dev-ml/base-0.16.3-r1:0/0.16::gentoo  USE="ocamlopt" 433 KiB
 [ebuild  N     ] dev-ml/parmap-1.2.5:0/1.2.5::gentoo  USE="ocamlopt" 48 KiB
 [ebuild  N     ] dev-ml/stdio-0.16.0:0/0.16::gentoo  USE="ocamlopt" 8 KiB
 [ebuild  N     ] dev-ml/parsexp-0.16.0:0/0.16::gentoo  USE="ocamlopt" 56 KiB
 [ebuild  N     ] dev-ml/sexplib-0.16.0-r1:0/0.16::gentoo  USE="ocamlopt" 54
 KiB
 [ebuild  N     ] dev-ml/pcre-ocaml-7.5.0:0/7.5.0::gentoo  USE="-examples
 ocamlopt" 41 KiB
 [ebuild  N    ~] dev-util/coccinelle-1.3.0::gentoo  USE="-doc -emacs ocamlopt
 pcre -python -test" PYTHON_SINGLE_TTotal: 20 packages (20 new), Size of
 downloads: 14168 KiB

 Would you like to merge these packages? [Yes/No]


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1: Package name mismatched, corrected
 Documentation/dev-tools/coccinelle.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
index 6e70a1e9a3c0..990a049091e1 100644
--- a/Documentation/dev-tools/coccinelle.rst
+++ b/Documentation/dev-tools/coccinelle.rst
@@ -29,6 +29,7 @@ of many distributions, e.g. :
  - Ubuntu
  - OpenSUSE
  - Arch Linux
+ - Gentoo
  - NetBSD
  - FreeBSD

--
2.52.0

