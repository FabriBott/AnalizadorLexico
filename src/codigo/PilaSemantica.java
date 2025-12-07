package codigo;

import java.util.Stack;

public class PilaSemantica {
    private Stack<Object> pila = new Stack<>();

    public void push(Object r) { 
        pila.push(r); 
    }

    public Object pop() { 
        return pila.pop(); 
    }

    public Object peek() { 
        return pila.peek(); 
    }

    public boolean empty() { 
        return pila.empty(); 
    }
}
