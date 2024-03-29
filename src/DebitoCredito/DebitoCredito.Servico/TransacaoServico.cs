﻿using DebitoCredito.Infra;
using System.Collections.Generic;
using DebitoCredito.Dominio.Entidades;
using DebitoCredito.Dominio.Interfaces.Infra;
using DebitoCredito.Dominio.Interfaces.Servicos;

namespace DebitoCredito.Servico
{
    public class TransacaoServico : ITransacaoServico
    {
        private readonly ILancamentos _lancamentos;
        private readonly IContasCorrentes _contasCorrentes;

        public TransacaoServico(ILancamentos lancamentos, IContasCorrentes contasCorrentes)
        {
            _lancamentos = lancamentos;
            _contasCorrentes = contasCorrentes;
        }

        public bool RealizarTransacao(Transacao transacao)
        {
            var realizarDebito = _contasCorrentes.RealizarDebito(transacao.ContaOrigem.Numero, transacao.Valor);

            if (!realizarDebito)
            {
                return false;
            }

            var lancamentoDebito = new Lancamento
            {
                Acao = "DEBITO",
                IdTransacao = VariaveisGlobais.Transacao.ToString(),
                NumeroContaCorrente = transacao.ContaOrigem.Numero,
                Valor = transacao.Valor
            };

            _lancamentos.InserirLancamentoAsync(lancamentoDebito);

            var realizarCredito = _contasCorrentes.RealizarCredito(transacao.ContaDestino.Numero, transacao.Valor);

            if (!realizarCredito)
            {
                return false;
            }

            var lancamentoCredito = new Lancamento
            {
                Acao = "CREDITO",
                IdTransacao = VariaveisGlobais.Transacao.ToString(),
                NumeroContaCorrente = transacao.ContaDestino.Numero,
                Valor = transacao.Valor
            };

            _lancamentos.InserirLancamentoAsync(lancamentoCredito);

            return true;
        }

        public IEnumerable<string> ValidarTransacao(Transacao transacao)
        {
            var erros = new List<string>();

            var validarValor = ValidarValor(transacao.Valor);
            if (!string.IsNullOrWhiteSpace(validarValor))
            {
                erros.Add(validarValor);
            }

            var validarContasCorrentes = ValidarContaCorrente(transacao.ContaOrigem.Numero, transacao.ContaDestino.Numero);
            if (!string.IsNullOrWhiteSpace(validarContasCorrentes))
            {
                erros.Add(validarContasCorrentes);
            }

            var validarContaCadastradaOrigem = _contasCorrentes.ValidarContaCadastrada(transacao.ContaOrigem.Numero);
            var validarContaCadastradaDestino = _contasCorrentes.ValidarContaCadastrada(transacao.ContaDestino.Numero);
            if (!validarContaCadastradaOrigem || !validarContaCadastradaDestino)
            {
                erros.Add("As contas correntes devem estar cadastradas");
            }

            return erros;
        }

        private string ValidarValor(decimal valor)
        {
            return (valor <= 0) ? "O valor da transação não pode ser negativo nem igual a zero": string.Empty;
        }

        private string ValidarContaCorrente(string contaOrigem, string contaDestino)
        {
            return 
                (string.IsNullOrWhiteSpace(contaOrigem) || string.IsNullOrWhiteSpace(contaDestino)) 
                ? "Os números das contas não podem ser vazios" 
                : string.Empty;
        }
    }
}
