Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB49FCD8CA8
	for <cocci@archiver.kernel.org>; Sat, 13 Jun 2026 14:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=uoJGjOOSsUg76E0G2K3/5MqWWKmni8p40Ef1THeGURY=;
  b=M7WW1qJrdVx/0LADhXOdMa8W7VEwMlENrNVV35DpQvD4Zn7PQ+UU3Hcn
   TmbUZHkdjvBF7N9GUNWYcq80VgZk6udMgZimxo+aMjbALvoNu2GqvAvDN
   /9Vo5K0khrvbkl1R7XySWrTJTqEkl2Qm6ZHFTqg4vXKrMNE5DKjXFWzfB
   0=;
X-CSE-ConnectionGUID: G9EUyu/lQS6RnFhLwxl7qQ==
X-CSE-MsgGUID: avxESOEkR+GYzjVdLZp7VQ==
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
X-IronPort-AV: E=Sophos;i="6.24,202,1774306800"; 
   d="scan'208";a="281378302"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2026 16:26:56 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 0482680E27; Sat, 13 Jun 2026 16:26:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 709EA8068D
	for <cocci@sympa.inria.fr>; Sat, 13 Jun 2026 16:26:52 +0200 (CEST)
X-CSE-ConnectionGUID: hW2uJvdQSEKsq/sRqToMCA==
X-CSE-MsgGUID: n9QjnentS7iXMUGjvnzgiw==
X-IronPort-AV: E=Sophos;i="6.24,202,1774306800"; 
   d="scan'208";a="149344724"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 16:26:52 +0200
Date: Sat, 13 Jun 2026 16:26:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <ab663a12-5993-48c2-aa0f-c093724cf930@web.de>
Message-ID: <c0702aae-dc4b-8ed8-11ab-107d6c523d74@inria.fr>
References: <c7c745e9-a593-4cca-8569-7dfe684dbce9@web.de> <0118baac-8e3e-48ac-ab6b-b326492627bb@web.de> <713ccb5e-331a-4e65-b91a-b6a6198c96e2@web.de> <ab663a12-5993-48c2-aa0f-c093724cf930@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2042387485-1781360812=:28904"
Subject: Re: [cocci] Searching for duplicate exception handling code with
 SmPL?
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3561
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/A1FmDrTaPLq8hBbc3kLKiA>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2042387485-1781360812=:28904
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

As usual, I have not idea what all your python code is supposed to do.  Is
it something other than the following:

@searching@
expression e, x;
identifier item, rc, work;
position p1, p2;
type T;
@@
 T work(...)
 {
 ... when any
 if (...)
 {
 ... when != rc = e
     when != item = x
 kfree@p1(item);
 return rc;
 }
 ... when any
 if (...)
 {
 ... when != rc = e
     when != item = x
 kfree@p2(item);
 return rc;
 }
 ... when any
 }

@script:ocaml@
p1 << searching.p1;
p2 << searching.p2;
@@

Printf.eprintf "duplicate on lines %d and %d\n" (List.hd p1).line (List.hd p2).line

This does print a report on your test data.

julia




On Sat, 13 Jun 2026, Markus Elfring wrote:

> >     But the desire is growing to reduce the presentation of unwanted
> >     false positives considerably.
> >     Thus there is a need to switch to more appropriate data formats.
> >     It seems then that multiple code occurrences can eventually be taken
> >     better into account with the help of SmPL position variables.
> >     Their information can be stored in databases probably also according
> >     to ACID criteria.
>
> Another SmPL script variant:
> @initialize:python@
> @@
> import sqlalchemy, sys
> sys.stderr.write("\n".join(["Using SQLAlchemy version:",
>                             sqlalchemy.__version__]))
> sys.stderr.write("\n")
> from sqlalchemy import Column, Integer, String, create_engine
> # outdated: from sqlalchemy.ext.declarative import declarative_base
> from sqlalchemy.orm import DeclarativeBase
> from sqlalchemy.orm import Mapped, mapped_column
> from sqlalchemy.orm import sessionmaker
> engine = create_engine("sqlite:///:memory:", echo=False)
> # outdated: base = declarative_base()
>
> class Base(DeclarativeBase):
>    pass
>
> class action(Base):
>    __tablename__ = "statements"
>    name: Mapped[str] = mapped_column(String, primary_key=True)
>    source_file: Mapped[str] = mapped_column(String, primary_key=True)
>    line: Mapped[int] = mapped_column(Integer, primary_key=True)
>    column: Mapped[int] = mapped_column(Integer, primary_key=True)
>    value1: Mapped[str] = mapped_column(String)
>    value2: Mapped[str] = mapped_column(String)
>
>    def __repr__(self):
>       return """<action(name='%s',
> source_file='%s',
> line='%s',
> column='%s',
> value1='%s',
> value2='%s')>""" % (self.name,
>                               self.source_file,
>                               self.line,
>                               self.column,
>                               self.value1,
>                               self.value2)
>
> class action2(Base):
>    __tablename__ = "statements2"
>    name: Mapped[str] = mapped_column(String, primary_key=True)
>    source_file: Mapped[str] = mapped_column(String, primary_key=True)
>    line: Mapped[int] = mapped_column(Integer, primary_key=True)
>    column: Mapped[int] = mapped_column(Integer, primary_key=True)
>    value1: Mapped[str] = mapped_column(String)
>    value2: Mapped[str] = mapped_column(String)
>
>    def __repr__(self):
>       return """<action2(name='%s',
> source_file='%s',
> line='%s',
> column='%s',
> value1='%s',
> value2='%s')>""" % (self.name,
>                               self.source_file,
>                               self.line,
>                               self.column,
>                               self.value1,
>                               self.value2)
>
> configured_session = sessionmaker(bind=engine)
> session = configured_session()
> # base.metadata.create_all(engine)
> #
> # See also:
> # https://stackoverflow.com/questions/70402667/how-to-use-create-all-for-sqlalchemy-orm-objects-across-files
>
> Base.metadata.create_all(engine)
>
> def store_data(fun, source1, source2, x, y):
>     """Add data to internal tables."""
>     for place in source1:
>        entry = action(name = fun,
>                       source_file = place.file,
>                       line = place.line,
>                       column = int(place.column) + 1,
>                       value1 = x,
>                       value2 = y)
>        session.add(entry)
>
>     for place in source2:
>        entry = action2(name = fun,
>                        source_file = place.file,
>                        line = place.line,
>                        column = int(place.column) + 1,
>                        value1 = x,
>                        value2 = y)
>        session.add(entry)
>
> @searching@
> expression e, x;
> identifier item, rc, work;
> position p1, p2;
> type T;
> @@
>  T work(...)
>  {
>  ... when any
>  if (...)
>  {
>  ... when != rc = e
>      when != item = x
>  kfree@p1(item);
>  return rc;
>  }
>  ... when any
>  if (...)
>  {
>  ... when != rc = e
>      when != item = x
>  kfree@p2(item);
>  return rc;
>  }
>  ... when any
>  }
>
> @script:python collection@
> fun << searching.work;
> x << searching.item;
> y << searching.rc;
> p1 << searching.p1;
> p2 << searching.p2;
> @@
> store_data(fun, p1, p2, x, y)
>
> @finalize:python@
> @@
> session.commit()
> from sqlalchemy import func
> entries = session.query(func.count("*")).select_from(action).scalar()
>
> if entries > 0:
>    from sqlalchemy import Index, Table, MetaData, select, text
>    from sqlalchemy.engine.reflection import Inspector
>    from sqlalchemy.sql import literal_column
>
>    pairs = Index("pairs", action.value1, action.value2)
>    pairs.create(engine)
>
>    # See also:
>    # https://stackoverflow.com/questions/30575111/how-to-create-a-new-table-from-select-statement-in-sqlalchemy#answer-30577608
>
>    q = session.query(action.value1, action.value2, action.name, action.source_file,
>                      func.count(literal_column("*")).label("C")
>                     ).group_by(action.value1,
>                                action.value2,
>                                action.name,
>                                action.source_file) \
>                      .having(func.count(literal_column("*")) > literal_column("1"))
>    session.execute(text('create table t2 as ' + str(q.statement)))
>
>    class results(Base):
>        __table__ = Table("t2", Base.metadata, autoload_with = session.connection())
>        __mapper_args__ = {
>            "primary_key": [__table__.c.source_file,
>                            __table__.c.name,
>                            __table__.c.value1,
>                            __table__.c.value2]
>                          }
>
>    entries2 = session.query(func.count("*")).select_from(results).scalar()
>
>    if entries2 > 0:
>       delimiter = "|"
>       sys.stdout.write(delimiter.join(["value1",
>                                        "value2",
>                                        '"function name"',
>                                        '"source file"',
>                                        "incidence"]))
>       sys.stdout.write("\r\n")
>       for value1, value2, name, source_file, incidence \
>           in session.query(results.value1,
>                            results.value2,
>                            results.name,
>                            results.source_file,
>                            results.C).order_by(results.source_file,
>                                                results.name,
>                                                results.value1,
>                                                results.value2):
>          sys.stdout.write(delimiter.join([value1,
>                                           value2,
>                                           name,
>                                           source_file,
>                                           str(incidence)]))
>          sys.stdout.write("\r\n")
>    else:
>       sys.stderr.write("Duplicate statements were not determined from "
>                        + str(entries) + " records.\n")
>       delimiter = "|"
>       sys.stderr.write(delimiter.join(["value1",
>                                        "value2",
>                                        '"function name"',
>                                        '"source file"',
>                                        "line"]))
>       sys.stderr.write("\r\n")
>       for value1, value2, name, source_file, line \
>           in session.query(action.value1,
>                            action.value2,
>                            action.name,
>                            action.source_file,
>                            action.line).order_by(action.source_file,
>                                                action.name,
>                                                action.value1,
>                                                action.value2,
>                                                action.line):
>          sys.stderr.write(delimiter.join([value1,
>                                           value2,
>                                           name,
>                                           source_file,
>                                           str(line)]))
>          sys.stderr.write("\r\n")
> else:
>    sys.stderr.write("No result for this analysis!\n")
>
>
>
> Corresponding source file example:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/sound/core/seq/seq_fifo.c#L17-L47
>
>
> // SPDX-License-Identifier: GPL-2.0-or-later
> // deleted part
> struct snd_seq_fifo *snd_seq_fifo_new(int poolsize)
> {
> 	struct snd_seq_fifo *f;
>
> 	f = kzalloc_obj(*f);
> 	if (!f)
> 		return NULL;
>
> 	f->pool = snd_seq_pool_new(poolsize);
> 	if (f->pool == NULL) {
> 		kfree(f);
> 		return NULL;
> 	}
> 	if (snd_seq_pool_init(f->pool) < 0) {
> 		snd_seq_pool_delete(&f->pool);
> 		kfree(f);
> 		return NULL;
> 	}
> // deleted part
> 	return f;
> }
> // deleted part
>
>
>
> Questionable test results:
> Markus_Elfring@Sonne:…/Projekte/Linux/next-analyses> git checkout next-20260608 && time /usr/bin/spatch …/Projekte/Coccinelle/janitor/list_selected_duplicate_statements_in_if_branches.cocci sound/core/seq/seq_fifo.c
> …
> Using SQLAlchemy version:
> 2.0.49
> …
> Duplicate statements were not determined from 1 records.
> value1|value2|"function name"|"source file"|line
> f|NULL|snd_seq_fifo_new|sound/core/seq/seq_fifo.c|28
>
> real    0m0,816s
> user    0m0,658s
> sys     0m0,148s
>
> Markus_Elfring@Sonne:…/Projekte/Coccinelle/Probe> time /usr/bin/spatch ../janitor/list_selected_duplicate_statements_in_if_branches.cocci snd_seq_fifo_new-excerpt-20260608.c
> …
> Using SQLAlchemy version:
> 2.0.49
> …
> Duplicate statements were not determined from 1 records.
> value1|value2|"function name"|"source file"|line
> f|NULL|snd_seq_fifo_new|snd_seq_fifo_new-excerpt-20260608.c|13
>
> real    0m0,785s
> user    0m0,649s
> sys     0m0,128s
>
>
>
> Would anybody like to explain the different determined values?
>
> How can presented expertise challenges be resolved?
>
> Regards,
> Markus
>
--8323329-2042387485-1781360812=:28904--
