package codigo;

import java.util.Stack;

public class PilaSemantica {
    private Stack<Registro> pila = new Stack<>();

    public void push(Registro r) { pila.push(r); }
    public Registro pop() { return pila.pop(); }
    public Registro peek() { return pila.peek(); }
    public boolean empty() { return pila.empty(); }
}
