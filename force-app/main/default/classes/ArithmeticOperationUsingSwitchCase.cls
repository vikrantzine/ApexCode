public with sharing class ArithmeticOperationUsingSwitchCase {
    public static Decimal performOperation(Decimal num1, Decimal num2, String operation) {
        Decimal result;
        
        switch on operation {
            when 'ADD' {
                result = num1 + num2;
            }
            when 'SUBTRACT' {
                result = num1 - num2;
            }
            when 'MULTIPLY' {
                result = num1 * num2;
            }
            when 'DIVIDE' {
                if (num2 != 0) {
                    result = num1 / num2;
                }
            }
        }
        return result;
    }
}