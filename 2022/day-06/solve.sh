#!/bin/bash

echo $((`cat input.txt | grep -P -bo '(.)(?!\1)(.)(?!\1|\2)(.)(?!\1|\2|\3)(.)' | head -1 | sed 's/:.*//'`+4))

echo $((`cat input.txt | grep -P -bo '(.)(?!\1)(.)(?!\1|\2)(.)(?!\1|\2|\3)(.)(?!\1|\2|\3|\4)(.)(?!\1|\2|\3|\4|\5)(.)(?!\1|\2|\3|\4|\5|\6)(.)(?!\1|\2|\3|\4|\5|\6|\7)(.)(?!\1|\2|\3|\4|\5|\6|\7|\8)(.)(?!\1|\2|\3|\4|\5|\6|\7|\8|\9)(.)(?!\1|\2|\3|\4|\5|\6|\7|\8|\9|\10)(.)(?!\1|\2|\3|\4|\5|\6|\7|\8|\9|\10|\11)(.)(?!\1|\2|\3|\4|\5|\6|\7|\8|\9|\10|\11|\12)(.)(?!\1|\2|\3|\4|\5|\6|\7|\8|\9|\10|\11|\12|\13)(.)' | head -1 | sed 's/:.*//'`+14))

