Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367E9C433EF
	for <cocci@archiver.kernel.org>; Wed, 30 Mar 2022 06:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Upj0YaAjIHg7LwZ8gYjFdHojisRvoPEaU9Jk8lm3iwE=;
  b=nj+5YcNZfnA3bUUJKzUxMo92itS4mq3lB2ItuO81wRX2ecOrcvGZU3uc
   XpjGnpo7ZJNEWoLyWVDfi17wbc7dSuodj/cZ1KPoPiC/inrySc6JUsz7g
   m42TXij07A+VxJ82dfjrGM3fCgy1FY1JltkRwSJC3ajBLLiHewIW1CWW+
   o=;
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
X-IronPort-AV: E=Sophos;i="5.90,221,1643670000"; 
   d="scan'208";a="29007430"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2022 08:39:30 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E5C40E7D84; Wed, 30 Mar 2022 08:39:29 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 70F42E7D80
	for <cocci@sympa.inria.fr>; Wed, 30 Mar 2022 01:21:58 +0200 (CEST)
IronPort-SDR: AH8pf+/IqJSe2DfEcOsH4PnMqHyKIqmtH24x4M/pWj3cG5ghxsEmIHTUjc4yjyn9HHG09+0tNh
 ixlGKM3C+n+SHbaJgjrfoFDrk6ieANBmDmIBGmMvZR5eF6j/7Gdacdw2emm4vn7AGI5qlGbSGE
 ADSpCiELfwWJTUmKLlNtr5ZoGNhIBe7tvXtJ2UtlxQwOMYZ8k5Gf0wGjvLNJMsbnDRm589Z5ty
 gqO0O7yXO92u/apt4JoIl6ddqVLa1FlFmEi36szhFpKx91Mn5MyBnD3fkaM0VneTWlawaaAA7Z
 CH8BwLi4kZT/14i+Jd7R9DrN
X-IPAS-Result: =?us-ascii?q?A0ABCAAJlENifzKgVdFaHgEBCxIMQIFPC4FSVoFVKwRPi?=
 =?us-ascii?q?y+VZQKBAoYViieBfAsBAwELAQFDBAEBhQeEVQIdBwEEMAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBEwEBDRQHCAoHDg5lAWEDAUSBT4FPJQsDM?=
 =?us-ascii?q?Q2CNSKDbhYoBgEbDw4BAxIQXhEBBQEjCymFRwEDLgGibIEEPYswgRcFF4EBg?=
 =?us-ascii?q?gkGhEkKGSgNZwOBWQIHCQEIgSqGEoQngxeBIYIphA+LMgSYcYEJBVuDHgG/I?=
 =?us-ascii?q?DEKBgGCIXM4gUGeNAUulkSSA5ZdIKY+AgoHBhAjEoEsZ4EuMxojgQFtgUtOA?=
 =?us-ascii?q?QIBAQENAQIBAQMBAgECCQEBAo4dg3KKeCc0OAIGCwEBAwmRYAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:SloLDq0EaYWEV8a7Y/bD5Qx3kn2cJEfYwER7XKvMYLTBsI5bpz1Rz
 jcZC2mBbKyIYmGnfN4gPdyzpE4FvZbSnYUxQAJr3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/nOH9IQMcacUsxLbVYMpBwJ1FQyw4bVvqYy2YLjW1jX6
 IuoyyHiEAbNNwBcYjp8B52r80sHUMTa4Fv0aXRjDRzjlAa2e0g9VPrzF4npR5fLatU88tqBe
 gr25OrRElU1UPsaIojNfr7TKiXmS1NJVOSEoiI+t6OK2nCuqsGuu0o2HKJ0VKtZt9mGt8t7y
 oxMu82Nc1wKIP3wobhAQisJMT4raMWq+JefSZS+mcmazkmDdHK1hvszVAc5OooX/usxCmZLn
 RAaAGpVP1bT2qTvnur9F7EEascLdKEHOKsas2trwDXeS+0tQZXCX7mTzdBd1TY0wMtJGJ4yY
 uJIOGs3N0qRC/FJEkk9OLUDp7qSvyn6UGZcj2is/7VqukGGmWSd15C0aIaPEjCQfu1emU2Tp
 0rd7mHhC1cbMsaewHyL6BqEgubQlCf/cJATEbei/7hrhkeSzyodEnUruUCTpPC4jgu5UosaJ
 RFMvCUpqqc2+QqgSdyVswCETGCspRQeAtteQtAAsyKTmpbtv1uINDkmUWsUADA5j/MeSTsv3
 16PutrmAz1zrbGYIU5xEJ/E/Vte3gBFfQc/iT84oRgtuIO++dpq5v7bZpMyTf/t0Yed9STYm
 mjS9EADa6MvYdnnPklR1XvOhS6roPAlpSZqu1yPBQpJAu6FDbNJiqSt4FnfqPFJdcOXEwHHs
 38DlMyTqusJCPlhdRBhos1TTNlFBN7falUwZGKD+bF/rlxBHFb+JuhtDMlWfhsBDyr9UWaBj
 LXvkQ1Q/oRPG3ChcLV6ZYm8Y+xzk/SwSIS8C6yJPoQUCnSUSONh1HE+DaJ39zC9+HXAbYliU
 XtmWZr0XSdDUfoPIMSeHr9AjOdDKt8CKZP7HMinlXxLIJKRY3maTbptDbd9RrFR0U9wmy2Mq
 4w3H5LSlX13CbSiCgGKoNZ7BQ1bdhATWMGmw+QJLLLrClQ9QwkJVaSBqY7NjqQ/wMy5YM+Tr
 i/jMqKZoXKj7UD6xfKiNyk7Mei1DM8lxZ/5VAR1VWuVN7EYSd7HxM8im1EfJNHLLcRvkqx5S
 ecrYcKFDqgdQzjL4WVPYpz0rYgkfxOu3FrcMy2gaTk5XphhWw2Zoo++LlWzrHEDXnitqM8zg
 7y8zQeEE5cOQgJVCsyJOv+iylWGu2cQxbBpVEzSL9gPI0jhqdA4KyH4gvItDdsLLBHPmmmT2
 wqMUEUXoODMp8k+99yQ3fKIqIKgEu1fGEtGHjmDvezma3WCpmf6mN1OSueFezzZRVjYwqT6a
 LUH1ez4Pd0GgE1O7NhxHrNt+qQ0uIniqrpc+QJ7RSmZYlmuDIRgFXmIx8x4sKNAm+1CsgysV
 0PTo9RXNOnbOM7hF1JNdgMpYv7ZjqMRkzjWqPM8eQD0uXcx872AXkFfeRKLjXUFfrdyNYokx
 8YnudIXu1Pj0Et0ao7eg3AG7XmII1wBT74j6sMQDrjth1d50VpFe5HdVnL77c3dcdlKKUV2c
 DaYiLCY3OZZz0vGNn06TD3DgLIbipMJtxRHilQFIg3RyNbCg/Y22jxX8Cg2HlsJlEQZi7orN
 zg5LVBxKIWP4yxs2JpJUVeqFlwTHxae4EHwlwYEmWCxo5NEjYARwLDR+Nph/Xz1N0pZdzlfu
 baRkSPrDG6sc8b20S8/H0VirpQPiDC3GhLqwKia8watRvHWogYJRoehYGMJr13sBsZZaIjvu
 7xx5OgpAUHkHXd4nkD4YrV2EZwfTRmFICpJRvQJEGbl243DUGna5AVi4Hxdti+AyzImPKN45
 wFTyhpzaimD
IronPort-HdrOrdr: A9a23:487zMqxOAEGNH4e4R+qwKrPwHb1zdoMgy1knxilNoNJuA6ilfu
 SV7Y8mPH7P+U4ssRQb8+xoV5PwIk80maQFg7X5Xo3SJTUO2lHYSr2KhLGKq1aBJ8SXzI9gPM
 xbAs9D4bPLfD1HZAXBjDVQ0exM/DBKys+VbC7loUtQcQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,220,1643670000"; 
   d="scan'208";a="9990369"
X-MGA-submission: =?us-ascii?q?MDGeWi0jV69LjRS06PMjdB1DdLIp8zxzLDlJKF?=
 =?us-ascii?q?yqIcGCdkC6eFu+xQEWW7mp6x7BDxMOq+8S7n2/h17YpnY4JMripS/Dzx?=
 =?us-ascii?q?+1wj4XtfETYhfeft6TdC0VDRAdOttjuU388G9g5V0SVH3Rcb0rOkEB8x?=
 =?us-ascii?q?LDZfvB4Sj/qSogAOH3M0LIdw=3D=3D?=
Received: from mail-oa1-f50.google.com ([209.85.160.50])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 01:21:56 +0200
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-de48295467so20436482fac.2;
        Tue, 29 Mar 2022 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Upj0YaAjIHg7LwZ8gYjFdHojisRvoPEaU9Jk8lm3iwE=;
        b=GhRQuIo5ZO/bfsxkkU42vkWb+WpXXnvB58zDU+aQa52kujXmaLh+dI9T9txmY6lwsF
         0RiuRQGcpIWmBrqvNe8+BTEwtdA8AEcm+q+Zk+hGoqmz2MlN2lvrmROxVYK3AvZEpUe+
         alrwAtT/dbEjJ95WnJRnxrCunkATzsQb7bbR207luGyQsQYJW3qk2hykGIO+/F/iLd68
         tdAU0cj1D3bUz+49uQY28XYw1jmXmPClT9dN0hjd72Gh1TOMbtONGFtPnuYqd1I9hPzM
         zFx0SUP6xui9taWYPHKd+wchqpxGEJ+oqSR6Y/OcWLFdha2wBxKfzqA9XE0wTm2L9o92
         /2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Upj0YaAjIHg7LwZ8gYjFdHojisRvoPEaU9Jk8lm3iwE=;
        b=Ebmr0FU5jnBJYLPMIeo/WSQFIacRexApRBYsLUXUpm6nXF1YWFwpvkWzC7c8Uxnj2T
         9+wCky7KQfIyoJYrB2IlHuARXJbk8xFGU+OS0NELYZqULrqUstlxCNbo6sEGGTHyZz7Q
         X3Lr8OvoU3lPwj2pLRgiwXTbyfCqh6SFfC/vT49oWgp25NPHsMRrq1OpkbxQinTNvc+7
         FYoLskkXzq+/zzoap8jQW7q4IKeFNJZbnykW8GN9q0YMGR/8UPx2r7fA65jSMkBETRt2
         UO8gWHQCu9gqPK/9xjdKBwG2Kh7wY6gBBZEe4u0TO13n3TbcddNuEMVCx/P1EYEWoHN4
         UaqA==
X-Gm-Message-State: AOAM531ciPuAuWkCocit7Be0EeFa7gDpbUze/tD/Ciiw35h8DtaV/SGb
	xiVcWQKHnRz8nEWbbiQoYBBSdQKy8ZWuyg==
X-Google-Smtp-Source: ABdhPJwt2GsmCq6MTV2PLGWD0zAbfAjRcS3J+9Y8MBRZ76lEqH/agkWdziL8qQpkkZl8OoqBGpw73g==
X-Received: by 2002:a05:6871:811:b0:dd:b8ea:6bb1 with SMTP id q17-20020a056871081100b000ddb8ea6bb1mr869561oap.43.1648596114721;
        Tue, 29 Mar 2022 16:21:54 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:d57:1503:f300:282c:2283:f732:e1c7])
        by smtp.gmail.com with ESMTPSA id a30-20020a4ad1de000000b00320fccd02cfsm9364788oos.5.2022.03.29.16.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:21:54 -0700 (PDT)
Date: Tue, 29 Mar 2022 20:21:48 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: corbet@lwn.net, mchehab+huawei@kernel.org, dlatypov@google.com,
	davidgow@google.com
Cc: linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, cocci@inria.fr,
	smatch@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, dan.carpenter@oracle.com,
	julia.lawall@inria.fr
Message-ID: <cover.1648593132.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v2 0/2] Add a section for static analysis tools
Reply-To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 307
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/cover.1648593132.git.marcelo.schmitt1%40gmail.com>

Hi,

Thanks to everybody who commented on v1 for your kind and much helpful feedback.

I tried to add suggestions and ideas while keeping the text concise.
Also, I took Dan and Julia's comments and included them into the
documentation (patch 2) because I think they were very helpful in
comparing the tools.
I didn't feel comfortable adding something comparing Sparse and
Coccinelle directly as I'm not an expert with any of these tools either.
Anyhow, that can be something to do in the future.

Thanks,
Marcelo

Marcelo Schmitt (2):
  Documentation: dev-tools: Add a section for static analysis tools
  Documentation: dev-tools: Enhance static analysis section with
    discussion

 Documentation/dev-tools/testing-overview.rst | 64 ++++++++++++++++++++
 1 file changed, 64 insertions(+)

-- 
2.35.1

