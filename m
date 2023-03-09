Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC85C6FD1C
	for <cocci@archiver.kernel.org>; Thu,  9 Mar 2023 09:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=6KoCTKH5mrtdqvoJqUYR6NfrXKK4r+sr5GhC+pWQ1B8=;
  b=clKTwlL1AqsdttBBFxhYfNHoxSSE+v3g65HPDCiBOiD4lXsMCA0+5eDu
   sGWg8CeX+C/3Z4UL+k+Unt3qCT8wLqR76AbElI1ZSxF1rmtp1eQO1fiuE
   Vvjb5PnljylyvFYPSKz5Zn5JGvQWKrXdWdITuxg+uycMZgZniMFuUlB+4
   I=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@gmail.com
X-IronPort-AV: E=Sophos;i="5.98,246,1673910000"; 
   d="txt'?scan'208";a="96242104"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Mar 2023 10:39:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E4138E01A7; Thu,  9 Mar 2023 10:39:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8DBDBE0119
	for <cocci@sympa.inria.fr>; Thu,  9 Mar 2023 10:10:07 +0100 (CET)
IronPort-SDR: 6409a26e_KqciDZx55QGBNXLFv2z0KM24IQaf2NWPgx6C0UfshSFEut6
 67BOlOJNyhuJXL8K2VozenucCAaS/jxSymviFZA==
X-IPAS-Result: =?us-ascii?q?A0FuAACGoQlkfzHdVdFaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItdVYvBFGIIoRQX4YBMycBAQEGgUIDjWuEKYs6gUA+CAcBAwELAQE5CQIEA?=
 =?us-ascii?q?QEDAQM4hEYChTICHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQEAQECEAEBGQkZBw4OBSSFaA2CNykBdU0DNwEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBBAJ+OQEBHgEBAQIBEhUZARsdAQMBCwYFR?=
 =?us-ascii?q?iMRAQUBHAYTIoJdgicBAw4jAwQMpWaBBEKLMIEBFgUCFoEBggkGgQebBAoZK?=
 =?us-ascii?q?A1rgVQHAgcJAQgVgRkBhDcjgmiIc3ongQMVgRCBFYMqPosDBIEFjgAlh28BA?=
 =?us-ascii?q?wICAwICAwYEAgICBQQCAQMEAg4EDgMBAQICAQECBAgCAgMDAggPEwMHAgEGB?=
 =?us-ascii?q?QEDAQIGBAIEAQsCBQIKAQIEAQICAgEFCQEDAQMBCwICBwIDBQYEAgMNAgEBA?=
 =?us-ascii?q?wICAg0DAgMCBAEFBQEBEAIGBAcBBgMLAgQBBAMBAgUHAwcDAgICAggEEgIDA?=
 =?us-ascii?q?gIEBQICAgECBAUCBwYCAQICAgQCAQMCBAICBAICBAMbAgMFAw4CAgICAQkLA?=
 =?us-ascii?q?gMHBAIDAwEHAgIMAQMYAwICAgICAgEDBwoECQQCBQECAQQLAQUBDQQCAgICA?=
 =?us-ascii?q?gMCAQEDBggGAwoCBQQDAwYJDw8IBQMBBAMCAwIBCAsCAwICBAgCAwECAgEGA?=
 =?us-ascii?q?gMBAgIBAgIBCwEBAgMFAgIRAQICAgICAQECAwIDAQcBAgIcBgQFAwMFAgIBB?=
 =?us-ascii?q?AECAgQEBQsCBAMBAQECAgICAwILAwUDAQYDAwoHBAEIAgYDBAIFBAMEBAYCA?=
 =?us-ascii?q?gICAgEEAQYLAwIEBAMDBgMJAgIMAhQCEgYBBAsLBAECAgIOAwQGAgMDAgIFC?=
 =?us-ascii?q?gQCAgICAgMGAgkEAgIDAwICAwMHAwECAgIFAQQFBgMCBAIBAwIEAgIEAwQBB?=
 =?us-ascii?q?wICAgICAwECAgMDAQIBBgMCAgIFAgIBCAIDAgICAgMDDwEBAQIKAgMBAQEFB?=
 =?us-ascii?q?AICCAIGAQICAgQEAQICAgICAgIMAwICAgMCAgYDAgIDOAMDAiADRB0CCQMjB?=
 =?us-ascii?q?QoDCwkIExcoBgwHNAQ0ARQHDAcHBioOBgIGAwQBCgsFBAUIAQIBAQYCBAIHC?=
 =?us-ascii?q?QwCAQYBBQICAwIBBQIBBgMBAgICAgUGBQMEBQMTAwEBBAMCAQIBAgMCAwcDA?=
 =?us-ascii?q?gQCAwECAwQGBgEJBAYFDQMEAgIBAgEBAwQEBAICAQICAwEEAgIBAQMDAwICA?=
 =?us-ascii?q?gMEAgMDCwQKBwMDAgEFCwQCAwIDAQYJBAICBgECBAICAgICAgMBAQMJBAIBA?=
 =?us-ascii?q?wICBAMGAgECAQkFAgEJAwECAQIBBAEDCQECAgQJAgMHBQoCAgICCAICDgMDA?=
 =?us-ascii?q?gEBBAICBAUJAQIHAgUBAQMFBwICAQICAQQDAQkEAQIDAgEBAxIDAwEEAgUDA?=
 =?us-ascii?q?w0JBgICAQMCAQ0DAQIBAgMBBQUXAwgHFAMFAgIEBAEHAgIDAwMCAQIJBgEDA?=
 =?us-ascii?q?QUCDgMCAgQGAQIBAQIDDwUBAQEBFwEDBAIDAQQDAQECAQIDDwQBBAULAxwCB?=
 =?us-ascii?q?AEICAICAwMBAgMFAQIDBAIBCAoCAgICCQIKAwIDAQMFAQMCCQMBBQECBwIGA?=
 =?us-ascii?q?QEBAgICBgIIAgMLAQMFBgIBAgIBBQIBAgIFAwUCAgICBA0CBQICAgUBAgcEA?=
 =?us-ascii?q?gICAwECAgYFAQIHBwIFAgICAwMKBAQHBAEBAQIBAQUBAgEDAwECBAECAQIFA?=
 =?us-ascii?q?wYCAgICAQICAQEBCAICAgICAgMEAgiYaYIMgTkRCUxbCoEaliaNAg6MHZQfB?=
 =?us-ascii?q?4N9hAGCNYUxlHtME5Z0kjaXYqJ5hHUCCgcGECMSgS06gVwzGiODNwlGAxkPj?=
 =?us-ascii?q?iCDQDKPekA0OwIHCwEBAwmFQyYTCwGFOwEB?=
IronPort-PHdr: A9a23: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
 nYL
IronPort-Data: A9a23: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
 dvSgIusT4WqiQbZ
IronPort-HdrOrdr: A9a23:q+8ahqHjehJIjdHlpLqE38eALOsnbusQ8zAXPo5KOHhom62j5r
 qTdZEgvyMc5wxhO03I9erwWpVoBEmsjKKdgrNhRotKPjOW3ldARbsKheCD/9SjIVyHygc078
 ZdmsNFebrN5DZB/KPHCcqDf+rIAuPrzEllv4jjJr5WIz1XVw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,245,1673910000"; 
   d="txt'?scan'208";a="96231959"
X-MGA-submission: =?us-ascii?q?MDHRQsnpEWkrZ/j8RMYRsCDt4ZLiKYvOLjDUq5?=
 =?us-ascii?q?Ga56tTAtpyBPDXQxKC+aIz1VG/3aUALPmTX7L8FiFpyqx5f0Led/OsZE?=
 =?us-ascii?q?gI9zba3qA7u9BVeah0kmeVEhlmXX0TnIzXAvDgHYtQopOcJ8/fugnFXR?=
 =?us-ascii?q?0knL+EgpfaH9AHD7beOcyNWg=3D=3D?=
Received: from mail-wr1-f49.google.com ([209.85.221.49])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 10:10:06 +0100
Received: by mail-wr1-f49.google.com with SMTP id v16so1181606wrn.0;
        Thu, 09 Mar 2023 01:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678353006;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6KoCTKH5mrtdqvoJqUYR6NfrXKK4r+sr5GhC+pWQ1B8=;
        b=U6L6ZdNOCgjuRQUrSRuqzONbUHkQBuD+pgEzAKBFbFHUurADjAjCW3wIBwdpeh4Z/h
         ZatOiuYVCUrTAo+43sRrRCAuAoTBNViRlDULPgphld8XW4ptnS2Qx+gxsn8mCqDlN+9F
         iX1eY6+RTFX32MJDUWNp/FFdec2CLPiEC3xCF/xq4ajudGbsJFN4WzHRAYn+T1QEotbo
         rwmGRhi+dvCYirEg1meRNPKttAVhXayYa3VMfWdj9+1/C7Dd5oWOcDgUssh125m23Af3
         voHOwUtsNs8CHQ3/EN1Ta3XKiRO9a/yMeSa35WiCxTJxlnKKJ0ocWbvsHR9Xx8akMdIi
         ukCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678353006;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KoCTKH5mrtdqvoJqUYR6NfrXKK4r+sr5GhC+pWQ1B8=;
        b=vNPDLXB1xD5dQXgXEAU3v/d1kUl7bDlWieKWyb71jqa6/HdptMGnmDBv5pKYM5AZs3
         f0jpxSCEUBRtiDfx4e5A7dH7+y3sEYcw/UMwqrUrp2ZFdpWDfjuZWJiZKVzVPrhEjneY
         MAbQyQDMHhKUSSNONbemedUBGY0JNLqKjzIrm0H2TZF+BhzVuWaO6hbuOJ12RQXGFZ1l
         eNhbY/aQnsqjt8pMqxezp6XOsJajwF7p5sLC4AHwcFf30wXkrZ9NiWgD9Q9Sr86/9uDG
         P2Xp+UvljDl7AjuRec7p9WctBg8H+MXzUV1i2kAx3iwrw0UrlUF1ZsIrfxqgKqcBgfRd
         V9qA==
X-Gm-Message-State: AO0yUKUftgP3l8ZDfYHQ+54lxh1sPbndFQCW09GWRF7dcg+yuvp4UoVa
	lrLcR2aN92RgvEULG7xvGzI=
X-Google-Smtp-Source: AK7set9B8LRtTNLBRcyaOgMA5efwHK2X57gQRmjzm6HtkRSHsRzHtxKNyBrBUelxcaMOI+ncm751Wg==
X-Received: by 2002:adf:da42:0:b0:2c7:16c3:175e with SMTP id r2-20020adfda42000000b002c716c3175emr13744774wrl.64.1678353006294;
        Thu, 09 Mar 2023 01:10:06 -0800 (PST)
Received: from nbbrfq (80-110-214-113.static.upcbusiness.at. [80.110.214.113])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d4c45000000b002c55306f6edsm16779923wrt.54.2023.03.09.01.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 01:10:05 -0800 (PST)
Date: Thu, 9 Mar 2023 10:10:01 +0100
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: rep.dot.nop@gmail.com, cocci@inria.fr
Message-ID: <20230309101001.78c0bc26@nbbrfq>
In-Reply-To: <ad666bb2-3f4-47a2-13fd-8f7e29b8af79@inria.fr>
References: <20230309092812.71b25d5c@nbbrfq>
	<89959f1e-b5ed-6b2c-2931-4fdd65428e89@inria.fr>
	<ad666bb2-3f4-47a2-13fd-8f7e29b8af79@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/ttWYWo5YXeNBpv9R3Tu84f2"
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] HELP: multiple inserts at one position
Reply-To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 883
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/20230309101001.78c0bc26%40nbbrfq>

--MP_/ttWYWo5YXeNBpv9R3Tu84f2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 9 Mar 2023 09:47:17 +0100 (CET)
Julia Lawall <julia.lawall@inria.fr> wrote:

> On Thu, 9 Mar 2023, Julia Lawall wrote:

> Another issue is that your semantic patch could be more efficient.  You
> have the declaration
> 
> type mpz_t;
> 
> I think you meant:
> 
> typedef mpz_t;
> 
> Then the only goal of the pattern
> 
> mpz_t i;
> ...
> 
> seems to be to ensure the type of i.  This can be done in the metavariable
> declaration:

I initially had a typedef, but thought i'd better simplify it, so yea.

> 
> local idexpression mpz_t i

Ok, i once had a local idexpression but without the type, thanks for
the hint!

> 
> and then in the second rule, it would be:
> 
> local idexpression mpz_t mpz_0_find.i;
> 
> In this way, you will not be matching from the top of the function, but
> rather only from the relevant call to the return.

Ah, excellent, many thanks! Works marvellous as attached.

Now, mere cosmetics, but is there a way to retain the spaces before the
braces in the replacement?
That would spare me a sed to obey to the coding conventions in gcc.
With the attached i get:
$ spatch --sp-file /tmp/mpz_free.0.cocci.txt /tmp/inp.cc
diff = 
--- /tmp/inp.cc
+++ /tmp/cocci-output-1431557-e530f9-inp.cc
@@ -54,6 +54,7 @@ CompileExpr::compile_integer_literal (co
   if (mpz_init_set_str (ival, literal_value.as_string ().c_str (), 10) != 0)
     {
       rust_error_at (expr.get_locus (), "bad number in literal");
+      mpz_clear(ival);
       return error_mark_node;
     }
 
@@ -69,6 +70,8 @@ CompileExpr::compile_integer_literal (co
 		     "integer overflows the respective type %<%s%>",
 		     tyty->get_name ().c_str ());
       mpz_clears (ival, expr, NULL); /* fake, just checking.. */
+      mpz_clear(type_min);
+      mpz_clear(type_max);
       return error_mark_node;
     }
 
@@ -77,5 +80,6 @@ CompileExpr::compile_integer_literal (co
   mpz_clear (type_min);
   mpz_clear (type_max);
 
+  mpz_clear(ival);
   return result;
 }


Thanks again!

--MP_/ttWYWo5YXeNBpv9R3Tu84f2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=mpz_free.0.cocci.txt

/// mpz ///////////////////////////////////////////////////////////////

@ mpz_0_find exists@
typedef mpz_t;
local idexpression mpz_t i;
position ret_pos;
@@
(
mpz_init_set_str (i, ...)
|
mpz_init (i)
|
mpz_init2 (i, ...)
|
mpz_init3 (i, ...)
)
... when != mpz_clear (i)
    when != mpz_clears (...,i,...)
(
  return \(<+...i...+>\);
|
return@ret_pos ...;
)

@ mpz_0_replace @
local idexpression mpz_t mpz_0_find.i;
position mpz_0_find.ret_pos;
@@
++ mpz_clear (i);
? return@ret_pos ...;


--MP_/ttWYWo5YXeNBpv9R3Tu84f2--
