// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reserva_vagas/models/exceptions.dart';
import 'package:reserva_vagas/services/holiday_service.dart';
import 'package:reserva_vagas/services/reservation_manager.dart';

/// ============================================================================
/// FIAP - AVALIAÇÃO PRÁTICA: TESTES DE UNIDADE COM MOCKTAIL NO FLUTTER
/// Duração: 50 minutos | Valor: 10,0 pontos
/// ============================================================================
/// NOME DO ALUNO:
/// RM:
/// ============================================================================

// 1. Definição do Mock com Mocktail (sem necessidade de build_runner!)
class MockHolidayService extends Mock implements HolidayService {}

void main() {
  late MockHolidayService mockHolidayService;
  late ReservationManager manager;

  final DateTime fixedNow = DateTime(2026, 10, 15, 10, 0, 0);

  setUpAll(() {
    // Registra fallbackValue para DateTime para uso com any() do Mocktail
    registerFallbackValue(DateTime(2026, 1, 1));
  });

  setUp(() {
    mockHolidayService = MockHolidayService();

    manager = ReservationManager(
      holidayService: mockHolidayService,
      baseHourlyRate: 10.0,
      currentTimeProvider: () => fixedNow,
    );

    // Comportamento default: dia normal (não é feriado)
    when(
      () => mockHolidayService.isHoliday(any()),
    ).thenAnswer((_) async => false);
  });

  group('1. Validações de Entrada (3,0 Pontos)', () {
    test(
      '1.1 Deve lançar InvalidPlateException quando a placa for nula ou não possuir 7 caracteres (1,0 pt)',
      () {
        // TODO: Teste que placas nulas, com menos de 7 ou com mais de 7 caracteres disparam InvalidPlateException.
        // DICA 1 (exceção): expect(() => manager.validatePlate('ABC'), throwsA(isA<InvalidPlateException>()));
        // DICA 2 (sucesso): expect(() => manager.validatePlate('BRA2E19'), returnsNormally);
        fail('Teste 1.1 ainda não implementado.');
      },
    );

    test(
      '1.2 Deve lançar InvalidDurationException quando as horas forem menores que 1 ou maiores que 24 (1,0 pt)',
      () {
        // TODO: Teste que valores de horas inválidos (< 1 ou > 24) disparam InvalidDurationException e que limites válidos (1 e 24) passam normalmente.
        // DICA: Use returnsNormally para testar os limites válidos 1 e 24:
        // expect(() => manager.validateDuration(1), returnsNormally);
        fail('Teste 1.2 ainda não implementado.');
      },
    );

    test(
      '1.3 Deve lançar InvalidReservationDateException quando o horário for anterior ao momento atual (1,0 pt)',
      () {
        // TODO: Teste que uma data no passado (anterior a fixedNow) dispara InvalidReservationDateException e uma futura passa normalmente com returnsNormally.
        fail('Teste 1.3 ainda não implementado.');
      },
    );
  });

  group('2. Regras de Cálculo e Descontos por Duração - Sem Mock (3,0 Pontos)', () {
    test(
      '2.1 Deve calcular o valor base sem nenhum desconto para reservas de menos de 4 horas (1,0 pt)',
      () async {
        // TODO: Calcule o preço para 3 horas (3h * R$ 10,00 = R$ 30,00).
        // Valide que baseAmount == 30.0, durationDiscount == 0.0 e totalAmount == 30.0.
        fail('Teste 2.1 ainda não implementado.');
      },
    );

    test(
      '2.2 Deve aplicar 10% de desconto sobre o valor base para reservas de 4 a 7 horas (1,0 pt)',
      () async {
        // TODO: Calcule o preço para 5 horas (5h * R$ 10,00 = R$ 50,00).
        // Valide que durationDiscount == 5.0 (10%) e totalAmount == 45.0.
        fail('Teste 2.2 ainda não implementado.');
      },
    );

    test(
      '2.3 Deve aplicar 20% de desconto sobre o valor base para reservas de 8 horas ou mais (1,0 pt)',
      () async {
        // TODO: Calcule o preço para 10 horas (10h * R$ 10,00 = R$ 100,00).
        // Valide que durationDiscount == 20.0 (20%) e totalAmount == 80.0.
        fail('Teste 2.3 ainda não implementado.');
      },
    );
  });

  group('3. Integração com Mocktail no HolidayService (3,0 Pontos)', () {
    test(
      '3.1 Deve aplicar acréscimo de 25% no valor base quando HolidayService retornar true (1,5 pt)',
      () async {
        // TODO: Configure o mock mockHolidayService para retornar true quando isHoliday for chamado:
        // Calcule o preço para 2 horas (base = 20.0, acréscimo feriado 25% = 5.0, total = 25.0).
        // Valide os valores e use verify(() => mockHolidayService.isHoliday(any())).called(1);
        fail('Teste 3.1 ainda não implementado.');
      },
    );

    test(
      '3.2 Não deve aplicar taxa de feriado quando HolidayService retornar false (1,5 pt)',
      () async {
        // TODO: Configure o mock mockHolidayService para retornar false.
        // Calcule o preço para 2 horas e valide que holidaySurcharge == 0.0 e total == 20.0.
        // Verifique a chamada com verify(...).called(1);
        fail('Teste 3.2 ainda não implementado.');
      },
    );
  });

  group('4. Resiliência a Exceções com Mocktail (1,0 Ponto)', () {
    test(
      '4.1 Deve manter o cálculo funcionando e assumir taxa de feriado zero se HolidayService lançar exceção (1,0 pt)',
      () async {
        // TODO: Configure o mock mockHolidayService para lançar uma exceção:
        // when(() => mockHolidayService.isHoliday(any())).thenThrow(Exception('Falha de rede'));
        // Calcule o preço para 2 horas e valide que não explode erro não tratado, isHoliday é false e totalAmount == 20.0.
        fail('Teste 4.1 ainda não implementado.');
      },
    );
  });
}
