﻿namespace DebitoCredito.Dominio.Interfaces.Infra
{
    public interface IContasCorrentes
    {
        bool ValidarContaCadastrada(string contaCorrente);
        bool RealizarDebito(string contaOrigem, decimal valor);
        bool RealizarCredito(string contaDestino, decimal valor);
    }
}
