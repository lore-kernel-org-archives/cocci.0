From: kumar.gala@linaro.org (Kumar Gala)
Date: Mon, 13 Feb 2017 13:22:47 -0500
Subject: [Cocci] Bitfield info?
In-Reply-To: <CA+MoWDoXAEwqyhZzicB3dk4R5gghnwfXTcOmFfF3kYA9svmNug@mail.gmail.com>
References: <1B4D9683-DB44-4445-8873-B7D29FC44F7B@linaro.org>
 <CA+MoWDoXAEwqyhZzicB3dk4R5gghnwfXTcOmFfF3kYA9svmNug@mail.gmail.com>
Message-ID: <682B6748-18A2-40EA-90D8-EB02B754B6C7@linaro.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> On Feb 13, 2017, at 1:14 PM, Peter Senna Tschudin <peter.senna@gmail.com> wrote:
> 
> On Mon, Feb 13, 2017 at 7:12 PM, Kumar Gala <kumar.gala@linaro.org> wrote:
>> Is there any support for bitfields?  Trying to see if something is of a bitfield type or not.
> 
> Can you give a code example?
> 
> Here are many examples, search for bit there: http://coccinellery.org/
> 
> 
> -- 
> Peter

Here, I?m wanting to figure out that p->state is a bitfield type:

----


typedef unsigned int uint32_t;

struct foo {
	uint32_t state:4;
};

void bar(struct foo *p)
{
	printf("%d", p->state);
}

??

@initialize:python@
@@
coccinelle.pd={}

@r@
typedef int8_t,int16_t,int32_t,int64_t,uint8_t,uint16_t,uint32_t,uint64_t,kpriority_t,net_stats_t,status_t;
{int8_t,int16_t,int32_t,int64_t,kpriority_t,net_stats_t,status_t,
uint8_t,uint16_t,uint32_t,uint64_t} x;
type T;
T y;
expression list[n] es;
constant char[] c;
identifier f;
position p;
@@

f(...,c at p,es,x at y,...)

@script:python collect@
p << r.p;  // position
f << r.f;  // func name
T << r.T;  // the type of the argument of interest
c << r.c;  // the format string
n << r.n;  // the offset of the argument of interest, counted from 0
y << r.y;
es << r.es;
@@
import re
print("km f:[%s] fmt:[%s] Type:[%s] offset:[%s] y:[%s] es[%s]" % (f, c, T, n, y, es))
