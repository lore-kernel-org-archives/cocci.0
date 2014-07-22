From: bjorn@mork.no (=?utf-8?Q?Bj=C3=B8rn_Mork?=)
Date: Tue, 22 Jul 2014 15:51:25 +0200
Subject: [Cocci] [PATCH] scripts: coccinelle: kfree with TRACE_RET
	before ref is ok (resent)
In-Reply-To: <20140722101217.GA16183@opentech.at> (Nicholas Mc Guire's message
 of "Tue, 22 Jul 2014 12:12:17 +0200")
References: <20140722101217.GA16183@opentech.at>
Message-ID: <87ha298psy.fsf@nemi.mork.no>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Nicholas Mc Guire <der.herr@hofr.at> writes:

> kfree.cocci currently triggers on constructs like
> (resending with proper CC list and subject line)
>
> drivers/staging/rts5208/spi.c
> 596    if (retval < 0) {
> 597            kfree(buf);
> 598            rtsx_clear_spi_error(chip);
> 599            spi_set_err_code(chip, SPI_HW_ERR);
> 600            TRACE_RET(chip, STATUS_FAIL);
> 601    }
> 602
> 603    rtsx_stor_access_xfer_buf(buf, pagelen, srb, &index, &offset,
>                             TO_XFER_BUF);
>
> with:
>
> ./drivers/staging/rts5208/spi.c:603:28-31: ERROR: reference preceded 
> by free on line 597
>
> but this should be fine - so TRACE_RET is added to the list of calls 
> "protecting" access to freed objects see drivers/staging/rts5208/trace.h

The TRACE_RET macro is a serious coding style violation. Fix that and
the error will go away.  Don't change scripts to hide issues with the
code. The code above won't just trigger an error in kfree.cocci but also
in the head of any sane person.

>From Documentation/CodingStyle:

<quote>
Things to avoid when using macros:

1) macros that affect control flow:

#define FOO(x)                                  \
        do {                                    \
                if (blah(x) < 0)                \
                        return -EBUGGERED;      \
        } while(0)

is a _very_ bad idea.  It looks like a function call but exits the "calling"
function; don't break the internal parsers of those who will read the code.
</quote>


Bj?rn
